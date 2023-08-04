<?php

namespace App\Http\Controllers;

use App\Models\Abonnement;
use App\Models\Paiement;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\AbonnementController;
use Exception;

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
                try {

                    $module_id = $request->module_id;

                    $user_id  = $request->user()->user_id;

                    $suscription = Abonnement::where('user_id', $user_id)->where('module_id', $module_id)->exists();

                    if (!$suscription) {

                        $paiement_creer = Paiement::create([
                            'paiement_amount' => $request->paiement_amount,
                            'module_id' => $request->module_id,
                            'paiement_ref' => $uniquekey,
                            // 'paiement_motif' => $request->,
                            'user_id' => $request->user()->user_id
                        ]);

                        return $this->retournresponse($paiement_creer);
                    } else {
                        //throw new Exception( "Vous êtes déjà abonné à ce module", 1);
                        return  $this->returnError('vous êtes déjà abonné à ce module', code: 402);
                    }
                } catch (\Throwable $th) {

                    return     $this->returnError($th->getMessage(), message: 'Error survenu' . $th, code: 402);
                }
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
                // 'paiement_id' => ['required', 'integer'],
                'paiement_ref' => 'string|required'
            ]);

            if ($validate->fails()) {
                return     $this->returnError($validate->errors(), message: 'Erreur de lors de la validation des donnes', code: 401);
            } else {

                $ref = $request->paiement_ref;

                $paiement_exist = Paiement::where('paiement_ref', $ref)->exists();

                if ($paiement_exist) {

                    $paiements = Paiement::where('paiement_ref', $ref)->first();

                    if ($paiements->paiement_status == true) {
                        return $this->returnError('Ce code n\'est plus valide.');
                    } else {
                        $module_id = $paiements->module_id;
                        Paiement::where('paiement_ref', $ref)->update(['paiement_status' => true]);
                        try {
                            $abonnement =
                                Abonnement::create([
                                    'paiement_id' => $paiements->paiement_id,
                                    'module_id' => $module_id,
                                    'user_id' => $request->user()->user_id
                                ]);
                            return $this->retournresponse($abonnement);
                        } catch (\Throwable $th) {
                            return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
                            //throw $th;
                        }
                    }
                } else {
                    return $this->returnError("Impossible d'utiliser votre code");
                }
            }
        } catch (\Throwable $th) {
            return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
        }
    }

    /**
     * Send reference by SMS to user who want to activate lecon
     */

     public function send_ref_to_user(Request $request) {                

        //TODO Envoyer un SMS au user.
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


// try {
                //     $abonnement =
                //         Abonnement::create([
                //             'paiement_id' => $id,
                //             'module_id' => $module_id,
                //             'user_id' => $request->user()->user_id
                //         ]);
                //     return $this->retournresponse($abonnement);
                // } catch (\Throwable $th) {
                //     return  $this->returnError('' . $th->getMessage(), message: $th->getMessage() ?? "Erreur inconue survenue lors de l'exécution de la requette");
                //     //throw $th;
                // }


                //    $reponse = $abonnement->create($id, $request->user()->user_id);