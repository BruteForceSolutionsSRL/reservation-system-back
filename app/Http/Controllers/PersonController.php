<?php

namespace App\Http\Controllers;

use Exception;

use Illuminate\Http\{
    JsonResponse as Response,
    Request
}; 

use Illuminate\Support\Facades\Validator;

use App\Service\ServiceImplementation\{
    PersonServiceImpl
};

class PersonController extends Controller
{
    private $personService; 

    public function __construct()
    {
        $this->personService = new PersonServiceImpl();
    }

    /**
     * Retrieve information about a single user based on its ID
     * @param int $userId
     * @param Request $request
     * @param Response
     */
    public function show(int $userId, Request $request): Response
    {
        try {
            return response()->json(
                $this->personService->getUser($userId),
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
     * Retrieve a response about a list of all persons
     * @param Request $request
     * @return Response
     */
    public function list(Request $request): Response
    {
        try {
            return response()->json(
                $this->personService->getAllUsers(),
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
     * Retrieve a response of all list teachers 
     * @param Request $request
     * @return Response
     */
    public function listTeachers(Request $request): Response 
    {
        try {
            return response()->json(
                $this->personService->getAllTeachers(),
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
     * Update its information
     * @param Request $request
     * @return Response
     */
    public function update(Request $request): Response 
    {
        try {
            $validator = $this->validateUpdateInformation($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(', ', $validator->errors()->all())],
                    400
                );
            }

            $data = $validator->validated();

            if (array_key_exists('role_ids', $data)) {
                return response()->json(
                    ['message' => 'Usted no puede modificar sus propios permisos de usuario'],
                    400
                );
            }

            return response()->json(
                $this->personService->update($data, $request['session_id']),
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
     * Validate a update request
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateUpdateInformation(Request $request) 
    {
        return Validator::make($request->all(), [
            'user_name' => 'string|min:3|unique:people,user_name',
            'email' => 'string|unique:people,email|regex:/^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/',
            'name' => 'string',
            'last_name' => 'string',
            'role_ids' => 'array',
            'role_ids.*' => 'integer|exists:roles,id',
        ], [
            'user_name.string' => 'El nombre de usuario debe ser una cadena no vacia.',
            'user_name.min' => 'El nombre de usuario debe ser una cadena con al menos 3 caracteres.',
            'user_name:unique' => 'El nombre de usuario ya existe, por favor intente con otro nombre.',
            
            'email.string' => 'El email debe ser una cadena no vacia.',
            'email.unique' => 'El email, ya le pertenece a otra persona.',
            'email.regex' => 'El campo email debe ser llenado con un email valido.',
            
            'name.string' => 'El/Los nombre(s) deben ser cadenas no nulas.',
            
            'last_name.string' => 'El/Los apellidos(s) deben ser cadenas no nulas.',

            'role_ids' => 'el campo roles debe ser de tipo array',
            'role_ids.*.integer' => 'los roles seleccionados deben hacer referencia a su id unico',
            'role_ids.*.exists' => 'los roles seleccionados no son validos, seleccione otros'
        ]);
    }

    /**
     * Update roles for a single person
     * @param \Illuminate\Http\Request $request
     * @param int $personId
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateRoles(Request $request, int $personId): Response 
    {
        try {
            $validator = $this->validateUpdateRoleInformation($request); 
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',', $validator->errors()->all())],
                    400
                );
            }

            $data = $validator->validated();

            if ($request['session_id'] == $personId) {
                return response()->json(
                    ['message' => 'Usted no puede cambiar sus propios permisos, intente con otro usuario.'],
                    400
                );
            }

            return response()->json(
                $this->personService->update($data, $personId),
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
     * Validate an update roles request
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Validation\Validator
     */
    private function validateUpdateRoleInformation(Request $request) 
    {
        return Validator::make($request->all(), [
            'role_ids' => 'required|array',
            'role_ids.*' => 'required|integer|exists:roles,id',
        ], [
            'role_ids' => 'el campo roles debe ser de tipo array',
            'role_ids.*.integer' => 'los roles seleccionados deben hacer referencia a su id unico',
            'role_ids.*.exists' => 'los roles seleccionados no son validos, seleccione otros'
        ]);
    }
}