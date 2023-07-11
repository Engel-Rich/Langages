<?php

namespace App\Http\Controllers;

use App\Models\Langue;
use App\Models\Module;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class LeconController extends RetourController
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
        $validator = Validator::make($request->all(),[
            'module' => ['integer', 'required'],
            'voice' => ['required', 'file'],
            // 'image' => ['required', 'file'],
            'title' =>['string', 'required'],
            'desciption' => 'string'
        ]);
        if($validator->failed()){
            $this->returnError($validator->errors(),code:402);
        }else{
            $module = $request->module;
            $courTitle = $request->title;
            $courDesc = $request->desciption;

            $isModuleExist = Module::where('module_id', $module)->exists();
            if($isModuleExist){
                $currentModule = Module::where('module_id', $module)->find()->first();
                
               try {
                $courVoice  = (string)Str::uuid().'.'. $request->voice->extension();
                $voice = Storage::url($request->file('voice')->storeAs('Lecons/'.$currentModule->langue_id.'/'.$module, $$courVoice,'public') )    ;            
                
                Langue::create([
                    'module_id'=>$module,
                    'lecon_title'=>$courTitle,
                    'lecon_voice'=>$voice,
                    'lecon_description'=>$courDesc
                ]);
               } catch (\Throwable $th) {
                $this->returnError($th->getMessage());
               }
            }else{
                $this->returnError('Undefine', message: 'Le module n\'as pas été trouvé', code: 402);
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
