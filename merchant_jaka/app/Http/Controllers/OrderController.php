<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class OrderController extends Controller
{
    public function index(){
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . session('api_token'),
        ])->get(env('BASE_URL_API') . "/orders?type=merchant&id=".session('merchant_id'));

        $orders = $response->json()['data'];

        return view('order', compact(['orders']));
    }

    public function matching(Request $request){
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . session('api_token'),
        ])->post(env('BASE_URL_API') . "/orders/accept", $request->all());

        if($response->successful()){
            return redirect()->back();
        }

        return redirect()->back()->withErrors(["error" => "Gagal Respon Pesanan"]);
    }
}
