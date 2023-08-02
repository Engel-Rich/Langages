<?php

namespace App\Http\Controllers;

use App\Models\Abonnement;
use App\Models\Langue;
use App\Models\Module;
use App\Models\Paiement;
use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;


class UserController extends RetourController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $userlist =  User::all();
            return $this->retournresponse($userlist);
        } catch (\Throwable $th) {
            $this->returnError('' . $th->getMessage());
        }
        // dd($userlist);
    }


    /**
     * Fontion de login
     */

    public function register(Request $request)
    {
        try {
            $validate = Validator::make($request->all(), [
                'phone' => ['required', 'string', 'min:9', 'max:13'],
                "name" => 'required',
                'email' => ['required', 'unique:users'],
                'password' => 'required|min:6|max:35',
                'ville' => 'required|string|min:3',
            ]);

            if ($validate->fails()) {
                return     $this->returnError($validate->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
            } else {
                $uniquekey = (string) Str::uuid();

                $user = User::create([
                    'name' => $request->name,
                    'email' => $request->email,
                    'ville' => $request->ville,
                    'user_key_generate' => (string)$uniquekey,
                    'password' => Hash::make($request->password),
                    'phone' => $request->phone
                ]);

                return $this->retournresponse([
                    'token' => $user->createToken("MON API DE LANGUES NATURELLES")->plainTextToken,
                    'idgenere' => $uniquekey,
                ]);
            }
        } catch (\Throwable $th) {
            return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
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
                'password' => 'string|required|min:6|max:35'
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
                    return   $this->returnError('Email ou mt de passe incorrecte', message: 'Email ou mot de passe incorrect', code: 401);
                }
            }
        } catch (\Throwable $th) {
            return     $this->returnError($th->getMessage(), message: 'Error' . $th, code: 403);
        }
    }

    public function get_user_abonnement(Request $request)
    {
        $id = $request->user()->user_id;

        $abonnements = Abonnement::where('user_id', $id)->get();
        $finalList = [];
        foreach ($abonnements as $abonnement) {


            $paiements_id = $abonnement->paiement_id;

            $paiements = Paiement::where('paiement_id', $paiements_id)->first();
            $module = Module::where('module_id', $abonnement->module_id)->first();
            $langue = Langue::where('langue_id', $module->langue_id)->first();
            array_push($finalList, [
                'Langues' => $langue,
                'Module' => $module,
                'Paiement' => $paiements,
            ]);
        }

        return $this->retournresponse($finalList);;
    }


    /**
     * Show the form for creating a new resource.
     */
    public function update_user_infos(Request $request, $id)
    {
        try {
            $validate = Validator::make($request->all(), [
                'phone' => ['required', 'string', 'min:9', 'max:13'],
                "name" => 'required',
                'email' => ['required', 'unique:users'],
                'password' => 'required|min:6|max:35',
                'ville' => 'required|string|min:3',
            ]);

            if ($validate->fails()) {
                return     $this->returnError($validate->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
            } else {
                $uniquekey = (string) Str::uuid();

                $user = User::find($id);
                    $user->name = $request->name;
                    $user->email = $request->email;
                    $user->ville = $request->ville;
                    $user->user_key_generate = (string)$uniquekey;
                    $user->password = Hash::make($request->password);
                    $user->phone = $request->phone;
                    $user->save();
                

                return $this->retournresponse([
                    'token' => $user->createToken("MON API DE LANGUES NATURELLES")->plainTextToken,
                    'idgenere' => $uniquekey,
                ]);
            }
        } catch (\Throwable $th) {
            return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
        }
    }

    
    public function delete_user($id)
    {
        $user = User::find($id);
        $user->delete();
        
        return $this->retournresponse('suppression réussi');
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
        return $this->retournresponse($request->user());
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
    public function update_profile_image(Request $request, $id)
    {
        $validation = Validator::make($request->all(), [
            'profile_image' => 'file|required|mimes:jpeg,png,jpg,svg|max:2560',
        ]);


        if ($validation->fails()) {
            // return $this->retournresponse($request->all());
            return     $this->returnError($validation->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {


            $name = (string)Str::uuid() . '.' . $request->file('profile_image')->extension();

            $url = Storage::url($request->file('profile_image')->storeAs('profile_image', $name, 'public'));

            $user = User::where('user_id', $id)->first();

            $user->user_id = $id;
            $user->profile_image = $url;
            $resultat = $user->save();

            return  $this->retournresponse($user);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
