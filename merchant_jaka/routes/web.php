<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\OrderController;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return redirect()->route('dashboard');
});

Route::get('/dashboard', function () {

    $bearerToken = session('api_token');

    // Call external API to store data with Bearer token in headers
    $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $bearerToken,
    ])->get(env('BASE_URL_API')."/products?merchant_id=".session('merchant_id'));

    $products = ($response->json())['data']??array();

    return view('dashboard', compact('products'));
})->name('dashboard');

Route::group(['middleware' => 'guest'], function () {
    // Routes that require authentication

    Route::get('/login', [AuthController::class, 'login'])->name('login.index');
    Route::post('/login', [AuthController::class, 'doLogin'])->name('login.do');

    Route::get('/register', [AuthController::class, 'register'])->name('register.index');
    Route::post('/register', [AuthController::class, 'doRegister'])->name('register.do');
});

Route::get('/logout/:token', [AuthController::class, 'logout'])->name('logout');

Route::get('/otp', [AuthController::class, 'otp'])->name('otp.index');
Route::post('/otp', [AuthController::class, 'doOtp'])->name('otp.do');

Route::get('/order', [OrderController::class, 'index'])->name('order');
Route::post('/matching', [OrderController::class, 'matching'])->name('orders.matching');

Route::resource('/products', \App\Http\Controllers\ProductController::class);
