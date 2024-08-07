<?php

namespace App\Http\Middleware;

use Closure;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\{
    JWTException,
    TokenInvalidException,
    TokenExpiredException
};
use Illuminate\Http\Request;

class JwtMiddlware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        try {
            $token = JWTAuth::parseToken();
            if ($token->getClaim('type') === 'refresh') {
                return response()->json(
                    ['status' => 'Token de refresco no permitido'], 
                    401
                );
            } else if ($token->getClaim('type') === 'access') {
                $person = $token->authenticate();
            } 
        } catch (JWTException $e) {
            if ($e instanceof TokenInvalidException) {
                return response()->json(
                    ['status' => 'Token invalido'], 
                    401
                );
            } else if ($e instanceof TokenExpiredException) {
                return response()->json(
                    ['status' => 'Token expirado'], 
                    401
                );
            } else {
                return response()->json(
                    ['status' => 'Token no encontrado',
                    'error' => $e->getMessage()], 
                    401
                );
            }
        }
        
        $request->merge(['session_id' => $person->id]);
        return $next($request);
    }
}
