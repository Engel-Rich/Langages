<?php

namespace App\Http\Controllers;

use App\Models\Langue;
use App\Models\Module;
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
            $this->returnError(''.$th->getMessage());
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
                'langue_name' => ['string', 'required', 'unique:langues','min:3'],
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
                return  $this->retournresponse('lange ajouté avec succès');
            } catch (\Throwable $th) {
                return   $this->returnError($th->getMessage(), message:'erreur inconnue',code:500);
            }
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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
            $modules = Module::where('langue_id',$langue_id);

        } catch (\Throwable $th) {            
        }
    }
}
