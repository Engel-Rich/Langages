<?php

namespace App\Http\Controllers;

use App\Models\Langue;
use App\Models\Module;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ModuleController extends RetourController
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
    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'langue' => ['required', 'integer'],
            'prix' => ['required', 'numeric'],
            'name' => ['required', 'string', 'min:3'],
            'image' => ['file', 'max:5120', 'mimes:png,jpg,jpeg']
        ]);

        if ($validator->failed()) {
            $this->returnError($validator->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {
            $langue = $request->langue;
            $isLangageExist = Langue::where('langue_id', $langue)->exists(); 
            if($isLangageExist){
                $prix = $request->prix;
                $name = $request->name;
    
                $hasImage = $request->file('iamge') != null;
    
                try {
    
                    $name_image = $hasImage ? (string)Str::uuid() . '.' . $request->file('iamge')->extension() : null;
    
                    $file = $hasImage ? Storage::url($request->file('iamge')->storeAs('Modules/' . $langue, $name_image, 'public')) : null;
                    Module::create([
                        'module_prix' => $prix,
                        'module_title' => $name,
                        'module_image' => $file,
                        'langue_id' => $langue
                    ]);
    
                } catch (\Throwable $th) {
                    $this->returnError($th->getMessage(), message: 'erreur inconnue', code: 500);
                }
            }else{
                $this->returnError('Undefine', message: 'La langue n\'as pas été trouvé', code: 402);
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
    public function destroy(string $id)
    {
        //
    }
}
