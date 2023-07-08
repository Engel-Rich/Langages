<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;


class UserController extends RetourController
{
    /**
     * Display a listing of the resource.
     */
    // public function index()
    // {
    //     //
    // }


    /**
     * Fontion de login
     */

    public function register(Request $request)
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
               
                return $this->retournresponse([
                    'token' => $user->createToken("MON API DE LANGUES NATURELLES")->plainTextToken,
                    'idgenere' => $uniquekey,
                ]);
            }
        } catch (\Throwable $th) {
            return  $this->returnError($th, code: 500);
        }
    }

    /**
     * Funtion de Login 
     */

    public function login(Request $request)
    {

        try {
            $validation = Validator::make($request->all(), [
                'email' => 'string|required',
                'password' => 'string|required|min:8|max:35'
            ]);
            if ($validation->fails()) {
                return    $this->returnError($validation->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
            } else {
                if (Auth::attempt($request->only(['email', 'password']))) {
                    $user = User::where('email', $request->email)->first();
                    return $this->retournresponse([
                        'token' => $user->createToken("MON API DE LANGUES NATURELLES")->plainTextToken,
                        'idgenere' => $user->user_key_generate,
                    ]);
                } else {
                    return   $this->returnError('error login', message: 'Email ou mot de passe incorrect', code: 401);
                }
            }
        } catch (\Throwable $th) {
            return     $this->returnError($th, message: 'Error' . $th, code: 500);
        }
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */

    //  public function savetoDatabase(Request $request)
    //  {

    //  }

    public function store(Request $request)
    {
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request)
    {
        return $request->user();    
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
