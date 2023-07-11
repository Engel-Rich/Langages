<?php

namespace App\Http\Middleware;

use App\Models\Admin;
use App\Models\Professeur;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ProfMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {

        try {
            $iduser = $request->user()->user_id;
        $isProf  = Professeur::where('user_id', $iduser)->exists();
        $isAdmin  = Admin::where('user_id', $iduser)->exists();
        if ($isProf)
            return $next($request || $isAdmin);
        else
            return response()->json(['message' => "authorization denied"], 403);
        } catch (\Throwable $th) {
            return response()->json(['message' => "authorization denied", 'error'=> $th->getMessage() ], 500);
        }
    }
}
