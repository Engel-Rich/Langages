<?php

namespace App\Http\Controllers;

use App\Models\Langue;
use App\Models\Lecon;
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
    public function index(Request $request)    
    {
        try {
            $modules  = Lecon::where('module_id', $request->module_id)->get();
            return   $this->retournresponse($modules);
        } catch (\Throwable $th) {
            return  $this->returnError($th->getMessage());
        }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'module_id' => ['integer', 'required'],
            'lecon_voice' => ['required', 'file'],
            'lecon_image' => ['file', 'max:5120', 'mimes:png,jpg,jpeg'],
            'lecon_title' =>['string', 'required'],
            // 'lecon_description' => 'string'
        ]);
        if($validator->fails()){
       return      $this->returnError($validator->errors(),code:402);
        }else{
            $module = $request->module_id;
            $courTitle = $request->lecon_title;
            $courDesc = $request->lecon_description;
            $isModuleExist = Module::where('module_id', $module)->exists();
            if($isModuleExist){
                $currentModule = Module::where('module_id', $module)->first();
                
               try {
                $courVoice  = (string)Str::uuid().'.'. $request->file('lecon_voice')->extension();
                $voice = Storage::url($request->file('lecon_voice')->storeAs('Lecons/'.$currentModule->langue_id.'/'.$module, $courVoice,'public') )    ;            
                
                Lecon::create([
                    'module_id'=>$module,
                    'lecon_title'=>$courTitle,
                    'lecon_voice'=>$voice,
                    'lecon_description'=>$courDesc
                ]);
               } catch (\Throwable $th) {
                return $this->returnError($th->getMessage());
               }
            }else{
                return $this->returnError('Undefine', message: 'Le module n\'as pas été trouvé', code: 402);
            }
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function create(Request $request)
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
