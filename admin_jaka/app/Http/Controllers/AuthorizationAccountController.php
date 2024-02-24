<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class AuthorizationAccountController extends Controller
{
    public function accept(Request $request)
    {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->post(env('BASE_URL_API') . '/auth/accept/' . $request->id, [
            'type' => $request->type,
        ]);

        return redirect()->back();
    }

    public function decline(Request $request)
    {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->post(env('BASE_URL_API') . '/auth/decline/' . $request->id, [
            'type' => $request->type,
        ]);
        return redirect()->back();
    }

    public function deactive(Request $request)
    {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->post(env('BASE_URL_API') . '/auth/deactivate/' . $request->id, [
            'type' => $request->type,
        ]);
        return redirect()->back();
    }

    public function active(Request $request)
    {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->post(env('BASE_URL_API') . '/auth/activate/' . $request->id, [
            'type' => $request->type,
        ]);
        return redirect()->back();
    }
}
