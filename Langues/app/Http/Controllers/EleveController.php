<?php

namespace App\Http\Controllers;

use App\Models\Eleve;
// use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class EleveController extends RetourController
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
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store()
    {
        try {
             Eleve::create([
                'user_id'=>auth()->user()->user_id,
            ]);
            return $this->retournresponse(['eleve_id'=>auth()->user()->user_id]);
           
        } catch (\Throwable $th) {
            return $this->returnError('Erreur de connection au serveur', message: 'Error : '.$th->getMessage(), code:500);
        }
        
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
