<?php

namespace App\Http\Controllers;

use App\Models\Professeur;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class ProfesseurController extends RetourController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function store(Request $request)
    {
        try {
            $validate = Validator::make($request->all(), [
                "name" => 'required',
                'email' => ['required', 'unique:users'],
                'password' => 'required|min:8|max:35',
                'ville'=> 'required|string|min:3'
            ]);

            if ($validate->fails()) {
                return     $this->returnError($validate->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
            } else {
                $uniquekey = (string) Str::uuid();

                $user = User::create([
                    'name' => $request->name,
                    'email' => $request->email,
                    'ville'=>$request->ville,
                    'user_key_generate' => (string)$uniquekey,
                    'password' => Hash::make($request->password),                    
                ]);
               Professeur::create(["user_id"=>$user->user_id]);
                return $this->retournresponse([
                    'token' => $user->createToken("MON API DE LANGUES NATURELLES")->plainTextToken,
                    'idgenere' => $uniquekey,
                ]);
            }
        } catch (\Throwable $th) {
            return  $this->returnError(''.$th->getMessage(), code: 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    // public function store()
    // {
    //     //
    // }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
