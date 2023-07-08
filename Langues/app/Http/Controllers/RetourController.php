<?php

namespace App\Http\Controllers;

// use Illuminate\Http\Request;

class RetourController extends Controller
{
    //
    public function retournresponse($result, string  $message = 'operation success', int $code = 200)
    {
        return response()->json([
            'status' => true,
            'message' => $message,
            'result' => $result
        ], $code);
    }

    public function returnError($error, string $message = "une erreur est survenue lors de l'exécution de la requette", int $code = 400)
    {
        return response()->json([
            'status' => false,
            'message' => $message,
            'error' => $error
        ], $code);
    }
}
