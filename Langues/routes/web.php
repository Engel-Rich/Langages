<?php

use App\Http\Controllers\LangueController;
use App\Http\Controllers\LeconController;
use App\Http\Controllers\ModuleController;
use App\Http\Controllers\PaiementController;
use App\Http\Controllers\ProfesseurController;
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
Route::resource('professeur', ProfesseurController::class);
Route::resource('langue', LangueController::class);
Route::resource('paiement', PaiementController::class);
Route::resource('module', ModuleController::class);
Route::resource('lecon', LeconController::class);