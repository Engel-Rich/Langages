<?php

namespace App\Http\Controllers;

use App\Models\Langue;
use App\Models\Module;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class LangueController extends RetourController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $userlist =  Langue::all();
            return $this->retournresponse($userlist);
        } catch (\Throwable $th) {
            $this->returnError('' . $th->getMessage());
        }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'langue_name' => ['string', 'required', 'unique:langues', 'min:3'],
                'langue_origine' => ['string', 'min:3'],
                'langue_image' => ['file', 'max:5120', 'mimes:png,jpg,jpeg']
            ]
        );
        if ($validator->fails())
            return  $this->returnError($validator->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        else {
            try {
                // $name = (string)Str::uuid() . '.' . $request->file('image')->extension();
                // $image = Storage::url($request->file('image')->storeAs('Langues', $name, 'public'));
                Langue::create([
                    'langue_image' => '',
                    'langue_name' => $request->langue_name,
                    'langue_origine' => $request->langue_origine ?? ""
                ]);
                return  $this->retournresponse('langue ajouté avec succès');
            } catch (\Throwable $th) {
                return   $this->returnError($th->getMessage(), message: 'erreur inconnue', code: 500);
            }
        }
    }

    public function update_langue_image(Request $request, $id)
    {
        $validation = Validator::make($request->all(), [
            'langue_image' => 'file|required|mimes:jpeg,png,jpg,svg|max:2560',
        ]);


        if ($validation->fails()) {
            // return $this->retournresponse($request->all());
            return     $this->returnError($validation->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {


            $name = (string)Str::uuid() . '.' . $request->file('langue_image')->extension();

            $url = Storage::url($request->file('langue_image')->storeAs('langue_image', $name, 'public'));

            $user = User::where('user_id', $id)->first();

            $user->user_id = $id;
            $user->langue_image = $url;
            $resultat = $user->save();

            return  $this->retournresponse($user);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function update_langue_infos(Request $request, $id)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'langue_name' => ['string', 'required', 'unique:langues', 'min:3'],
                'langue_origine' => ['string', 'min:3'],
                'langue_image' => ['file', 'max:5120', 'mimes:png,jpg,jpeg']
            ]
        );
        if ($validator->fails())
            return  $this->returnError($validator->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        else {
            try {
                // $name = (string)Str::uuid() . '.' . $request->file('image')->extension();
                // $image = Storage::url($request->file('image')->storeAs('Langues', $name, 'public'));
                $langue = Langue::find($id);
                $langue->langue_image = '';
                $langue->langue_name = $request->langue_name;
                $langue->langue_origine = $request->langue_origine ?? "";
                $langue->save();
                return  $this->retournresponse('langue modifié avec succès');
            } catch (\Throwable $th) {
                return   $this->returnError($th->getMessage(), message: 'erreur inconnue', code: 500);
            }
        }
    }

    public function delete_langue($id)
    {
        $langue = Langue::find($id);
        $langue->delete();
        
        return $this->retournresponse('suppression réussi');
    }

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
    public function destroy(Request $request)
    {
        try {
            $langue_id = $request->lange_id;
            $modules = Module::where('langue_id', $langue_id);
        } catch (\Throwable $th) {
        }
    }
}
