<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use App\Models\User;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AdminController extends RetourController
{
    //

    function store(Request $request)
    {
      
       try {
        $validat = Validator::make($request->all(), [
            'user_id' => ['required', 'integer']
        ] );

        if($validat->fails()){
            return $this->returnError($validat->errors(), code:402);
        }else{
            $user = User::where('user_id', $request->user_id)->exists();
            if($user){
            try {
                Admin::create([
                    'user_id' => $request->user_id,
                ]);
                return $this->retournresponse(['admin' => $user]);
            } catch (\Throwable $th) {
                return $this->returnError($th->getMessage());
            }
            }else{
             return $this->returnError('undefined', code:404, message:"user ".$request->user_id." not fund");
            }
        }
       } catch (\Throwable $th) {
        return $this->returnError($th->getMessage());
       }
       
    }
}
