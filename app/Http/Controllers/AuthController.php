<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Exceptions\{
    JWTException,
    TokenInvalidException,
    TokenExpiredException
};
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\{
    Auth,
    Validator
};

use App\Service\ServiceImplementation\{
    PersonServiceImpl,
    AuthServiceImpl
};

use Exception;

class AuthController extends Controller
{
    private $personService;
    private $authService;

    public function __construct()
    {
        $this->personService = new PersonServiceImpl();
        $this->authService = new AuthServiceImpl();
    }

    /**
     * Function to register people
     * @param Request $request
     * @return Response
     */
    public function register(Request $request): Response
    {

        $validator = $this->validatePersonData($request);

        if ($validator->fails()) {
            $message = '';
            foreach ($validator->errors()->all() as $value)
                $message = $message . $value . '.';
            return response()->json(
                ['message' => $message],
                400
            );
        }

        $data = $validator->validated();

        try {
            $person = $this->authService->store($data);
        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Error en el servidor',
                    'error' => $e->getMessage()
                ],
                500
            );
        }

        return response()->json(
            [
                'message' => 'Usuario creado exitosamente!',
                'person' => $person
            ],
            201
        );
    }

    /**
     * Validate all data of person
     * @param Request $request
     * @return mixed
     */
    private function validatePersonData(Request $request)
    {
        return Validator::make($request->all(), [
            'name' => 'required|string',
            'last_name' => 'required|string',
            'user_name' => 'required|string|unique:people',
            'email' => 'required|email|unique:people',
            'password' => 'required|string|min:8|max:50',
        ],[
            'name.required' => 'El/Los nombre/s del usuario es obligatorio',

            'last_name.required' => 'El/Los apellido/s del usuario es obligatorio',

            'user_name.required' => 'El nick name ya se encuentra en uso',
            'user_name.unique' => 'El nick name no esta disponible',

            'email.required' => 'El correo es obligatorio',
            'email.email' => 'Ingrese un correo valido',
            'email.unique' => 'El correo ya se encuentra registrado',

            'password.required' => 'La contraseña es obligatoria',
            'password.string' => 'La contraseña tiene que tener un formato valido',
            'password.min' => 'La cantidad de caracteres minima para una contraseña es 8',
            'password.max' => 'La cantidad de caracteres maxima para una contraseña es 50'
        ]);
    }

    /**
     * Handle a incomplete login request to the application
     * @param Request $request
     * @return Response
     */
    public function incompleteLogin(Request $request): Response
    {

        $validator = $this->validateIncompleteLoginData($request);
        if ($validator->fails()) {
            return response()->json(
                ['message' => implode(',', $validator->errors()->all())],
                400
            );
        }

        $data = $validator->validated();

        $login = filter_var($data['login'], FILTER_VALIDATE_EMAIL) ? 'email':'user_name';

        $credentials = [
            $login => $data['login'],
            'password' => $data['password']
        ];

        try {

            $claims = [
                'type' => 'access',
                'faculty_id' => -1
            ];
            if (!$accessToken = JWTAuth::claims($claims)->attempt($credentials)) {
                return response()->json(
                    ['message' => 'Login fallido'],
                    401
                );
            }
            
            $person = Auth::user();

            return response()->json(
                [
                    'person' => $this->personService->personToArray($person),
                    'access_token' => $accessToken,
                ],
                200
            );
        } catch (JWTException $e) {
            return response()->json(
                [
                    'message' => 'Error en el servidor',
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }

    /**
     * Validate all data of incomplete login
     * @param Request $request
     * @return mixed
     */
    private function validateIncompleteLoginData(Request $request)
    {
        return Validator::make($request->all(), [
            'login' => 'required|string',
            'password' => 'required|string|min:8|max:50'
        ], [
            'login.required' => 'Ingrese su correo o nombre de usuario',

            'password.required' => 'La contraseña es obligatoria',
            'password.string' => 'La contraseña tiene que tener un formato valido',
            'password.min' => 'La cantidad de caracteres minima para una contraseña es 8',
            'password.max' => 'La cantidad de caracteres maxima para una contraseña es 50'
        ]);
    }

    /** 
     * Handle a complete login request to the application
     * @param Request $request
     * @return Response
    */
    public function completeLogin(Request $request): Response
    {
        $validator = $this->validateCompleteLoginData($request);
        if ($validator->fails()) {
            $message = '';
            foreach ($validator->errors()->all() as $value)
                $message = $message . $value . '.';
            return response()->json(
                ['message' => $message],
                400
            );
        }

        $data = $validator->validated();
        $token = JWTAuth::parseToken();
        $person = $token->authenticate();
        
        try {

            $claims = [
                'type' => 'access',
                'faculty_id' => $data['faculty_id']
            ];
            if (!$accessToken = JWTAuth::claims($claims)->fromUser($person)) {
                return response()->json(
                    ['message' => 'Login fallido'],
                    401
                );
            }

            JWTAuth::factory()->setTTL(config('jwt.refresh_ttl'));
            $claims = ['type' => 'refresh'];
            if (!$refreshToken = JWTAuth::claims($claims)->fromUser($person)) {
                return response()->json(
                    ['message' => 'Login fallido'],
                    401
                );
            }

            JWTAuth::invalidate($token);
        
            return response()->json(
                [
                    'person' => $this->personService->personToArray($person),
                    'access_token' => $accessToken,
                    'refresh_token' => $refreshToken
                ],
                200
            );
        } catch (JWTException $e) {
            return response()->json(
                [
                    'message' => 'Error en el servidor',
                    'error' => $e->getMessage()
                ],
                500
            );
        }

    }

    /**
     * Validate all data of complete login
     * @param Request $request
     * @return mixed
     */
    private function validateCompleteLoginData(Request $request)
    {
        return Validator::make($request->all(), [
            'faculty_id' => 'required|Integer'/* |exists:,id' */,
        ], [
            'faculty_id.required' => 'Seleccione una facultad',
            /* 'faculty_id.exists' => 'La faculta selecciona no existe' */
        ]);
    }

    /**
     * Function to recover password with email of an user
     * @param string
     * @return Response
     */
    public function resetPassword(Request $request): Response
    {
        try {
            $validator = $this->validateResetPasswordData($request);
    
            if ($validator->fails()) 
                return response()->json(
                    ['message' => implode('.',$validator->errors()->all())], 
                    400
                );

            $data = $validator->validated();

            return response()->json(
                $this->authService->resetPassword($data),
                200
            );

        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }

    /**
     * Function to validate the email of users to recover their passwords.
     * @param Request $request
     * @return mixed
     */
    private function validateResetPasswordData(Request $request)
    {
        return Validator::make($request->all(),[
            'email' => '
                required|
                email|
                exists:people,email'
        ],[
            'email.required'=> 'Debe ingresar un correo',
            'email.email'=> 'Debe ingresar un correo valido',
            'email.exists'=> 'El correo ingresado no se encuentra registrado'
        ]);
    }

    /**
     * Function to change password by email
     * @param Request $request
     * @return Response
     */
    public function changePassword(Request $request): Response
    {
        try {
            $validator = $this->validatChangePasswordData($request);
    
            if ($validator->fails()) 
                return response()->json(
                    ['message' => implode('.',$validator->errors()->all())], 
                    400
                );

            $data = $validator->validated();

            $data['session_id'] = $request['session_id'];

            $person = $this->authService->changePassword($data);
            
            $credentials = [
                'email' => $person['person_email'],
                'password' => $data['new_password']
            ]; 

            try {
                if (!$accessToken = JWTAuth::claims(['type' => 'access'])->attempt($credentials)) {
                    return response()->json(
                        ['message' => 'Autenticacion fallida'],
                        401
                    );
                }
                JWTAuth::factory()->setTTL(config('jwt.refresh_ttl'));
                if (!$refreshToken = JWTAuth::claims(['type' => 'refresh'])->fromUser(Auth::user())) {
                    return response()->json(
                        ['message' => 'Autenticacion fallida'],
                        401
                    );
                }
    
            } catch (JWTException $e) {
                return response()->json(
                    [
                        'message' => 'Error en el servidor',
                        'error' => $e->getMessage()
                    ],
                    500
                );
            }

            return response()->json(
                [
                    'access_token' => $accessToken,
                    'refresh_token' => $refreshToken,
                    'person' => $person
                ],
                200
            );

        } catch (Exception $e) {
            return response()->json(
                [
                    'message' => 'Hubo un error en el servidor',
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }

    /**
     * Validate data for password recovery and change
     * @param Request $request
     * @return mixed
     */
    private function validatChangePasswordData(Request $request)
    {
        return Validator::make($request->all(), [
            'new_password' => 'required|string|min:8|max:50',
            'confirmation_password' => 'required|string|min:8|max:50|same:new_password'
        ],[
            'new_password.required' => 'La contraseña nueva es obligatoria',
            'new_password.string' => 'La contraseña nueva tiene que tener un formato valido',
            'new_password.min' => 'La cantidad de caracteres minima para la contraseña nueva es 8',
            'new_password.max' => 'La cantidad de caracteres maxima para la contraseña nueva es 50',

            'confirmation_password.required' => 'La contraseña de confirmacion es obligatoria',
            'confirmation_password.string' => 'La contraseña de confirmacion tiene que tener un formato valido',
            'confirmation_password.min' => 'La cantidad de caracteres minima para la contraseña de confirmacion es 8',
            'confirmation_password.max' => 'La cantidad de caracteres maxima para la contraseña de confirmacion es 50',
            'confirmation_password.same' => 'La contraseña de confirmacion no coincide con la nueva contraseña'
        ]);
    }

    /**
     * 
     * @param Request $request
     * @return Response
     */
    public function logout(Request $request):Response
    {

        $accessToken = $request->bearerToken();
        $refreshToken = $request->header('Refresh_token');
        
        if (!$accessToken) {
            return response()->json(
                ['message' => 'Token de acceso no proporcionado'],
                400
            );
        }

        if (!$refreshToken) {
            return response()->json(
                ['message' => 'Token de refresco no proporcionado'],
                400
            );
        }

        try {
            JWTAuth::setToken($accessToken);
            if (JWTAuth::getPayload()->get('type') === 'access') {
                JWTAuth::invalidate($accessToken);
            } else {
                return response()->json(
                    ['message' => 'Token de acceso inválido'], 
                    401
                );
            }
            JWTAuth::setToken($refreshToken);
            if (JWTAuth::getPayload()->get('type') === 'refresh') {
                JWTAuth::invalidate($refreshToken);
            } else {
                return response()->json(
                    ['message' => 'Token de refresco inválido'], 
                    401
                );
            }
            
            return response()->json(
                [
                    'success' => true,
                    'message' => 'Usuario desconectado'
                ],
                200
            );
        } catch (TokenExpiredException $e) {
            return response()->json(
                ['message' => 'Token ya expirado'],
                401
            );
        } catch (TokenInvalidException $e) {
            return response()->json(
                ['message' => 'Token inválido'],
                401
            );
        } catch (JWTException $e) {
            return response()->json(
                [
                    'success' => false,
                    'message' => 'Error al invalidar el token',
                    'error' => $e->getMessage()
                ],
                500
            );
        }
    }

    /**
     * Function to verify the validity of a token
     * @param Request $request
     * @return Response
     */
    public function tokenStatus(Request $request):Response
    {
        try {
            JWTAuth::parseToken()->authenticate();
            return response()->json(
                ['status' => 'Token valido'], 
                200
            );
            
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
    }

    /**
     * Refresh the JWT token.
     * @param Request $request
     * @return Response
     */
    public function tokenRefresh(Request $request): Response
    {
        try {
            $refreshToken = $request->bearerToken();
            JWTAuth::setToken($refreshToken);
            if (JWTAuth::getPayload()->get('type') !== 'refresh') {
                return response()->json(
                    ['message' => 'Token de refresco inválido'], 
                    401
                );
            }
            $newToken = JWTAuth::claims(['type' => 'access'])->refresh($refreshToken);
            return response()->json(
                ['token' => $newToken], 
                200
            );
        } catch (TokenExpiredException $e) {
            return response()->json(
                ['message' => 'Token de refresco expirado'],
                401
            );
        } catch (TokenInvalidException $e) {
            return response()->json(
                ['message' => 'Token de refresco inválido'], 
                401
            );
        } catch (JWTException $e) {
            return response()->json(
                [
                    'message' => 'Error al refrescar el token',
                    'error' => $e->getMessage()
                ], 
                500
            );
        }
    }
}