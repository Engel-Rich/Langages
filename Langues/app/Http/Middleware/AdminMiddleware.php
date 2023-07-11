<?php

namespace App\Http\Middleware;

use App\Models\Admin;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {

       try {
        $userId = $request->user()->user_id;

        $isAdmin = Admin::where('user_id', $userId)->exists();
        if ($isAdmin)
            return $next($request);
        else
            return response()->json(['message' => "authorization denied"], 403);
       } catch (\Throwable $th) {
        return response()->json(['message' => "authorization denied", 'error'=> $th->getMessage() ], 500);
       }
    }
}
