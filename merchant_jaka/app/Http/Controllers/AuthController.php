<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;

class AuthController extends Controller
{
    public function login()
    {
        return view('login');
    }

    public function doLogin(Request $request)
    {
        // Call external API to authenticate user
        $response = Http::post(env('BASE_URL_API')."/auth/login", [
            'phone' => $request->input('phone'),
            'password' => $request->input('password'),
            'type' => 'merchant',
        ]);

        // Check if authentication was successful
        if ($response->successful()) {
            $userData = $response->json(); // Assuming your API returns user data
            $token = $userData['data']['token']; // Assuming your API returns a token

            $request->session()->put('api_token', $token);
            $request->session()->put('merchant_id', $userData['data']['user']['id']);
            $request->session()->put('merchant_name', $userData['data']['user']['name']);
            $request->session()->put('merchant_phone', $userData['data']['user']['phone']);

            if($userData['data']['user']['is_activated'] == null){
                return redirect()->route('otp.index');
            }

            return redirect()->route('dashboard');
        } else {
            return redirect()->route('login.index')->with('error', 'Authentication failed');
        }
    }

    public function otp()
    {
        return view('otp');
    }

    public function doOtp(Request $request)
    {
        // Call external API to authenticate user
        $response = Http::post(env('BASE_URL_API')."/auth/verify-otp", [
            'phone' => session('merchant_phone'),
            'otp' => $request->input('otp'),
            'token' => session('api_token'),
            'type' => 'merchant',
        ]);

        // Check if authentication was successful
        if ($response->ok()) {
            return redirect()->route('dashboard');
        } else {
            return redirect()->route('login.index')->with('error', 'Authentication failed');
        }
    }

    public function register()
    {
        return view('register');
    }

    public function doRegister(Request $request)
    {
        $requestData = array_merge($request->all(), ['type' => 'merchant']);

        // Call external API to register user
        $response = Http::post(env('BASE_URL_API')."/auth/register", $requestData);

        // Check if registration was successful
        if ($response->ok()) {
            // Redirect the user to the dashboard or wherever you want
            return $this->doLogin($request);
        } else {
            return redirect()->route('register.index')->with('error', 'Registration failed');
        }
    }

    public function logout(Request $request)
    {
        // Clear authentication
        $response = Http::post(env('BASE_URL_API')."/auth/logout", $request->all());

        // Clear token from session or any other storage mechanism
        if($response->ok()){
            $request->session()->forget('api_token');
        }

        // Redirect the user to the login page
        return redirect()->route('login.index');
    }
}
