<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\EleveController;
use App\Http\Controllers\LangueController;
use App\Http\Controllers\LeconController;
use App\Http\Controllers\ModuleController;
use App\Http\Controllers\PaiementController;
use App\Http\Controllers\ProfesseurController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AbonnementController;
use App\Models\Langue;
use App\Models\Module;
use App\Models\Professeur;
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
    Route::get('/langue/all', [LangueController::class, 'index']);
    Route::resource('/langue', LangueController::class)->only(['show']);
    Route::resource('/paiement', PaiementController::class)->only(['store', 'show']);
    Route::get("/module/index", [ModuleController::class, 'index']);
    Route::get("/module/show/{module}", [ModuleController::class, 'show']);
    Route::get("/lecon/index", [LeconController::class, 'index']);
    Route::get("/lecon/show/{lecon}", [LeconController::class, 'show']);

    Route::post('/admin/create', [AdminController::class, 'store']);

    Route::middleware(['admin'])->prefix('admin/professeur')->group(function () {
        Route::get('all', [ProfesseurController::class, 'index']);
        Route::post('create', [ProfesseurController::class, 'store']); //->only(['create', 'update','destroy','show']);
    });

    Route::middleware(['prof'])->group(function () {
        Route::resource('/module', ModuleController::class)->only(['store', 'update', 'destroy']);
        Route::resource('/lecons', LeconController::class)->only(['store', 'update', 'destroy']);
        Route::post('/langue/create', [LangueController::class, 'create']);
    });

    Route::get('paiement/get/{type}', [PaiementController::class, 'index']);
    Route::post('paiement/actif', [PaiementController::class, 'actif_paiement']);
    Route::post('paiement/create', [PaiementController::class, 'create']);
    Route::post('abonnement/create', [AbonnementController::class, 'create']);
    Route::get('abonnement/get/all', [UserController::class, 'get_user_abonnement']);



    Route::post('user/update/profile/{id}', [UserController::class, 'update_profile_image']);
    Route::post('user/update/infos/{id}', [UserController::class, 'update_user_infos']);
    Route::post('module/update/image/{id}', [ModuleController::class, 'update_module_image']);
    Route::post('module/update/infos/{id}', [ModuleController::class, 'update_module_infos']);
    Route::post('langue/update/image/{id}', [LangueController::class, 'update_langue_image']);
    Route::post('langue/update/infos/{id}', [LangueController::class, 'update_langue_infos']);

    Route::delete('delete/user/{id}', [UserController::class, 'delete_user']);
    Route::delete('delete/module/{id}', [ModuleController::class, 'delete_module']);
    Route::delete('delete/langue/{id}', [LangueController::class, 'delete_langue']);
    
});




Route::post('user/register', [UserController::class, 'register']);
Route::post('user/login', [UserController::class, 'login']);
Route::get('user/all', [UserController::class, 'index']);
Route::get('test', function () {
    return response()->json(['distante' => 'Ok']);
});
Route::post('admin/create', [AdminController::class, 'store']);
