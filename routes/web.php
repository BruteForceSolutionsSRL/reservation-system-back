<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/{any}', function () {
    return view('index');
})->where('any', '^(?!api/).*$');

Route::get('/password/reset/{token}', function ($token) {
  return redirect()->to(env('FRONTEND_URL')."/password-reset".$token);
})->name('password.reset');

/*
Route::fallback(function ($request) {
  if (!str_starts_with($request->url(), '/api')) {
    return Response::json([
      'message' => 'Invalid route. Please use the API for requests to /api endpoints.',
      'status' => 404
    ], 404);
  }

  // If it's an API request, let Laravel's default routing handle it
  return response();
});
*/
