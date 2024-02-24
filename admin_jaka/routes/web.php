<?php

use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\AuthorizationAccountController;
use App\Http\Controllers\ProfileController;
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
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/verifikasi-penjamu', function () {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->get(env('BASE_URL_API') . '/penjamus');
        $penjamus = ($response->json()) ? ($response->json())['data'] : array();

        return view('verifikasi-penjamu', compact(['penjamus']));
    })->name('verifikasi.penjamu');

    Route::get('/manage-user', function () {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->get(env('BASE_URL_API') . '/users');
        $users = ($response->json()) ? ($response->json())['data'] : array();

        return view('manage-user', compact(['users']));
    })->name('manage.user');

    Route::get('/manage-merchant', function () {
        $bearerToken = env('BEARER_TOKEN_API');

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $bearerToken,
        ])->get(env('BASE_URL_API') . '/merchants');
        $merchants = ($response->json()) ? ($response->json())['data'] : array();

        return view('manage-merchant', compact(['merchants']));
    })->name('manage.merchant');

});
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::post('/accept/{id}', [AuthorizationAccountController::class, 'accept'])->name('auth.accept');
    Route::post('/decline/{id}', [AuthorizationAccountController::class, 'decline'])->name('auth.decline');
    Route::post('/deactive/{id}', [AuthorizationAccountController::class, 'deactive'])->name('auth.deactive');
    Route::post('/active/{id}', [AuthorizationAccountController::class, 'active'])->name('auth.active');

    Route::get('register', [RegisteredUserController::class, 'create'])
        ->name('register');

    Route::post('register', [RegisteredUserController::class, 'store']);
});

require __DIR__ . '/auth.php';
