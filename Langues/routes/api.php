<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\EleveController;
use App\Http\Controllers\LangueController;
use App\Http\Controllers\LeconController;
use App\Http\Controllers\ModuleController;
use App\Http\Controllers\PaiementController;
use App\Http\Controllers\ProfesseurController;
use App\Http\Controllers\UserController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user/show', [UserController::class, 'show']);
    Route::resource('eleve', EleveController::class)->except(['index', 'create']);
    Route::resource('langue', LangueController::class)->only(['show']);
    Route::resource('paiement', PaiementController::class)->only(['store', 'show']);
    Route::resource('module', ModuleController::class)->only(['show']);
    Route::resource('lecon', LeconController::class)->only(['show']);   
    Route::post('admin/create',[AdminController::class, 'store']); 


    Route::middleware(['admin'])->prefix('admin/professeur')->group(function () {
        Route::post('create', [ProfesseurController::class,'store']); //->only(['create', 'update','destroy','show']);
    });
    
    Route::middleware(['prof'])->group(function () {
        Route::resource('module',ModuleController::class  )->only(['create', 'update','destroy','show']);    
        Route::resource('lecons', LeconController::class )->only(['create', 'update','destroy','show']);    
    });

});



Route::post('user/register', [UserController::class, 'register']);
Route::post('user/login', [UserController::class, 'login']);
Route::get('test',function(){
    return response()->json(['distante'=> 'Ok']);
} );
// Route::post('admin/create',[AdminController::class, 'store']);
