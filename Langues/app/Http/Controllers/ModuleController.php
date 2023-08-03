<?php

namespace App\Http\Controllers;

use App\Models\Langue;
use App\Models\Module;
use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ModuleController extends RetourController
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        try {
            $modules  = Module::where('langue_id', $request->langue_id)->get();
            return  $this->retournresponse($modules);
        } catch (\Throwable $th) {
            return  $this->returnError($th->getMessage());
        }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'langue_id' => ['required', 'integer'],
            'module_prix' => ['required', 'numeric'],
            'module_title' => ['required', 'string', 'min:3'],
            'module_image' => ['file', 'max:5120', 'mimes:png,jpg,jpeg']
        ]);

        if ($validator->fails()) {
            return $this->returnError($validator->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {
            $langue = $request->langue_id;
            $isLangageExist = Langue::where('langue_id', $langue)->exists();
            if ($isLangageExist) {
                $prix = $request->module_prix;
                $name = $request->module_title;

                $hasImage = $request->file('module_image') != null;

                try {
                    $name_image = $hasImage ? (string)Str::uuid() . '.' . $request->file('iamge')->extension() : null;
                    $file = $hasImage ? Storage::url($request->file('module_image')->storeAs('Modules/' . $langue, $name_image, 'public')) : null;
                    Module::create([
                        'module_prix' => $prix,
                        'module_title' => $name,
                        'module_image' => $file,
                        'langue_id' => $langue
                    ]);

                    return  $this->retournresponse('module ajouté avec succès');
                } catch (\Throwable $th) {
                    return $this->returnError($th->getMessage(), message: 'erreur inconnue', code: 500);
                }
            } else {
                return $this->returnError('Undefine', message: 'La langue n\'as pas été trouvé', code: 402);
            }
        }
    }

    public function update_module_image(Request $request, $id)
    {
        $validation = Validator::make($request->all(), [
            'module_image' => 'file|required|mimes:jpeg,png,jpg,svg|max:2560',
        ]);


        if ($validation->fails()) {
            // return $this->retournresponse($request->all());
            return     $this->returnError($validation->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {


            $name = (string)Str::uuid() . '.' . $request->file('module_image')->extension();

            $url = Storage::url($request->file('module_image')->storeAs('module_image', $name, 'public'));

            $module = Module::where('module_id', $id)->update([
                'module_id' => $id,
                'module_image' => $url
            ]);

            // $module->module_id = $id;
            // $module->module_image = $url;
            // $resultat = $module->save();

            return  $this->retournresponse($module);
        }
    }

    public function update_module_infos(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'langue_id' => ['required', 'integer'],
            'module_prix' => ['required', 'numeric'],
            'module_title' => ['required', 'string', 'min:3'],
        ]);

        if ($validator->fails()) {
            return $this->returnError($validator->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {
            $langue = $request->langue_id;
            $isLangageExist = Langue::where('langue_id', $langue)->exists();
            if ($isLangageExist) {
                $prix = $request->module_prix;
                $name = $request->module_title;

                $hasImage = $request->file('module_image') != null;

                try {
                    $module = Module::where('module_id', $id)->update([
                        'module_prix'=> $prix,
                        'module_title' => $name,
                        'langue_id' => $langue
                    ]);
                    // $module->module_prix = $prix;
                    // $module->module_title = $name;
                    // $module->langue_id = $langue;
                    
                

                    return  $this->retournresponse($module);
                } catch (\Throwable $th) {
                    return $this->returnError($th->getMessage(), message: 'erreur inconnue', code: 500);
                }
            } else {
                return $this->returnError('Undefine', message: 'La langue n\'as pas été trouvé', code: 402);
            }
        }
    }

    
    public function delete_module($id)
    {
        $module = Module::where('module_id', $id);
        $module->delete();

        return $this->retournresponse('suppression réussi');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function create(Request $request, $id)
    {
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
