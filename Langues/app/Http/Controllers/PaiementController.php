<?php

namespace App\Http\Controllers;

use App\Models\Abonnement;
use App\Models\Paiement;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\AbonnementController;

class PaiementController extends RetourController
{
    /**
     * Display a listing of the resource.
     */
    public function index($type)
    {


        try {

            // Récupère tous les abonnements et verifier leurs statuts
            $paiements =  $type == 'all' ? Paiement::all() : ($type == true ? Paiement::where('paiement_status', '=', true)->get() : Paiement::where('paiement_status', '=', false)->get());

            return $this->retournresponse($paiements);
        } catch (\Throwable $th) {
            return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
        }
    }



    public function create(Request $request)
    {
        try {
            $validate = Validator::make($request->all(), [
                'paiement_amount' => ['required', 'integer'],
                'module_id' => ['required', 'integer']
            ]);

            if ($validate->fails()) {
                return     $this->returnError($validate->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
            } else {

                $uniquekey = (string) Str::uuid();
                

                do {
                    $uniquekey = (string) Str::uuid();
                } while (Paiement::where('paiement_ref', $uniquekey)->exists());

               
    $paiement_creer = Paiement::create([
                        'paiement_amount' => $request->paiement_amount,
                        'module_id' => $request->module_id,
                        'paiement_ref' => $uniquekey,
                        // 'paiement_motif' => $request->,
                        'user_id' => $request->user()->user_id
                    ]);
                    return $this->retournresponse($paiement_creer);
            }
        } catch (\Throwable $th) {
            return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
        }
    }
    
    
    //fonction qui retourne l'etat du paiement inactif a actif
    public function actif_paiement(Request $request)
    {
        try {
            
        $validate = validator::make($request->all(), [
            'paiement_id' => ['required', 'integer']
        ]);

        if($validate->fails())
        {
            return     $this->returnError($validate->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
        } else {
            $id = $request->paiement_id;
            // $paiements = Paiement::find()
            Paiement::where('paiement_id',$id)->update(['paiement_status'=>true]);
           try {
            $abonnement = 
            Abonnement::create([
                'paiement_id' => $id,
                'user_id' =>$request->user()->user_id
            ]);
        return $this->retournresponse($abonnement);

           } catch (\Throwable $th) {
            return  $this->returnError(''.$th->getMessage(), message: $th->getMessage()??"Erreur inconue survenue lors de l'exécution de la requette");
            //throw $th;
           }
  

    //    $reponse = $abonnement->create($id, $request->user()->user_id);
        }
    } catch (\Throwable $th) {
        return  $this->returnError(''.$th->getMessage(), message: $th->getMessage()??"Erreur inconue survenue lors de l'exécution de la requette");

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
