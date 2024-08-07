<?php

namespace App\Http\Controllers;

use Illuminate\Http\{
	Request,
	JsonResponse as Response
};

use App\Service\ServiceImplementation\ConstantServiceImpl; 

class ConstantController extends Controller
{
	private $constantsService; 

	public function __construct() 
	{
		$this->constantsService = new ConstantServiceImpl();
	}

	/**
	 * Retrieve a status of a single constant 'AUTOMATIC_RESERVATIONS'
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function getAutomaticReservationConstant(): Response
	{
		try {
			return response()->json(
				$this->constantsService->getAutomaticReservationConstant(), 
				200
			);
		} catch (\Exception $e) {
			return response()->json(
				[
					'message' => 'Hubo un error en el servidor.', 
					'error' => $e->getMessage()
				],
				500
			);
		}
	}

	/**
	 * Retrieve a status of a single constant 'MAXIMAL_RESERVATION_PER_GROUP'
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function getMaximalReservationPerGroup(): Response
	{
		try {
			return response()->json(
				$this->constantsService->getMaximalReservationPerGroup(), 
				200
			);
		} catch (\Exception $e) {
			return response()->json(
				[
					'message' => 'Hubo un error en el servidor.', 
					'error' => $e->getMessage()
				],
				500
			);
		}
	}

	public function updateAutomaticReservationConstant(): Response
	{
		try {
			$this->constantsService->updateAutomaticReservation(); 
			return response()->json(
				$this->constantsService->getAutomaticReservationConstant(), 
				200
			);
		} catch (\Exception $e) {
			return response()->json(
				[
					'message' => 'Hubo un error en el servidor.', 
					'error' => $e->getMessage()
				],
				500
			);
		}
	}

	public function updateMaximalReservationPerGroup(Request $request): Response
	{
		try {
			$validator = $this->validateConstantMaximalReservationPerGroup($request); 
			if ($validator->fails()) {
				return response()->json(
					['message' => implode(',', $validator->errors()->all())], 
					400
				);
			}
			$data = $validator->validated();
			$this->constantsService->updateMaximalReservationPerGroup($data);
			return response()->json(
				$this->constantsService->getMaximalReservationPerGroup(), 
				200
			);
		} catch (\Exception $e) {
			return response()->json(
				[
					'message' => 'Hubo un error en el servidor.', 
					'error' => $e->getMessage()
				],
				500
			);
		}
	}
	/**
	 * Validate a updateMaximalReservationPerGroup request
	 * @param \Illuminate\Http\Request $request
	 * @return \Illuminate\Validation\Validator
	 */
	private function validateConstantMaximalReservationPerGroup(Request $request) 
	{
        return \Validator::make($request->all(), [
            'quantity' => 'required|integer|min:2|max:50',
        ], [
            'quantity.required' => 'El número de estudiantes es obligatorio.',
            'quantity.integer' => 'El número de estudiantes debe ser un valor entero.',
            'quantity:min' => 'La cantidad debe ser un numero positivo mayor o igual a 25',
            'quantity:max' => 'La cantidad debe ser un numero positivo menor o igual a 500',
        ]);
	}

}
