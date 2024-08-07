<?php
namespace App\Http\Controllers;

use Illuminate\Http\{
    JsonResponse as Response,
    Request
};
use Exception;

use App\Service\ServiceImplementation\{
    BlockServiceImpl,
    ClassroomServiceImpl
};

use Illuminate\Support\Facades\Validator;

class BlockController extends Controller
{
    private $blockService;
    private $classroomService;
    public function __construct()
    {
        $this->blockService = new BlockServiceImpl();
        $this->classroomService = new ClassroomServiceImpl();
    }

    /**
     * Retrieve a list of all blocks registered
     * @param Request $request
     * @return Response
     */
    public function list(Request $request): Response
    {
        try {
            $facultyId = \JWTAuth::parseToken($request->bearerToken())->getClaim('faculty_id');
            if ($facultyId === -1) {
                $facultyIds = $request->input('faculty_ids'); 
                if (empty($facultyIds)) {
                    return response()->json(
                        $this->blockService->getAllBlocks(),
                        200
                    );
                } else {
                    return response()->json(
                        $this->blockService->getBlocksByFaculties($facultyIds),
                        200
                    );
                }
            } else {
                return response()->json(
                    $this->blockService->getBlocksByFaculties([$facultyId]),
                    200
                );
            }
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
     * Retrieve a list of all blocks with statistics of used classrooms by dates and time_slots
     * @param Request $request
     * @return Response
     */
    public function listBlocksForSpecial(Request $request): Response
    {
        try {

            $validator = $this->validateForListBlocks($request);
            if ($validator->fails()) {
                return response()->json(
                    ['message' => implode(',', $validator->errors()->all())],
                    400
                );
            }
            $data = $validator->validated();
            return response()->json(
                $this->blockService->listBlocksForSpecialReservation($data),
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
     * Validate body data passed to validate date and time slots
     * @param Request $request
     * @return mixed
     */
    private function validateForListBlocks(Request $request)
    {
        return Validator::make($request->all(), [
            'date_start' => 'required|date',
            'date_end' => 'required|date',
            'time_slot_ids.*' => 'required|exists:time_slots,id',
            'time_slot_ids' => [
                'required',
                'array',
                function ($attribute, $value, $fail) {
                    if (count($value) !== 2) {
                        $fail('Debe seleccionar exactamente dos periodos de tiempo.');
                    }else if ($value[1] <= $value[0]) {
                        $fail('El segundo periodo debe ser mayor que el primero.');
                    }
                }
            ],
        ], [
            'date_start.required' => 'La fecha es obligatoria.',
            'date_start.date' => 'La fecha debe ser un formato válido.',
            'date_end.required' => 'La fecha es obligatoria.',
            'date_end.date' => 'La fecha debe ser un formato válido.',
            'time_slot_id.*.required' => 'Se requieren los periodos de tiempo.',
            'time_slot_id.*.exists' => 'Uno de los periodos de tiempo seleccionados no es válido.',
            'time_slot_id.required' => 'Se requieren dos periodos de tiempo.',
            'time_slot_id.array' => 'Los periodos de tiempo deben ser un arreglo.',
        ]);
    }


    /**
     * Retrieve a single block by its ID
     * @param int $blockId
     * @param Request $request
     * @return Response
     */
    public function show(int $blockId, Request $request): Response
    {
        try {
            return response()->json(
                $this->blockService->getBlock($blockId),
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
     * Retrieve a response including statistical information
     * @param int $blockId
     * @param Request $request
     * @return Response
     */
    public function getBlockStatistics(int $blockId, Request $request): Response
    {
        try {
            return response()->json(
                $this->blockService->getBlockStatistics($blockId),
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
     * Store a single block
     * @param Request $request
     * @return Response
     */
    public function store(Request $request): Response
    {
        try {
            $validator = $this->validateBlockData($request);
            if ($validator->fails())
                return response()->json(
                    ['message' => implode('.', $validator->errors()->all())],
                    400
                );

            $data = $validator->validated();

            if (!empty($this->blockService->findByName($data['name'])))
                return response()->json(
                    ['message' => 'El nombre del bloque '.$data['name'].' ya existe, por favor escriba otro nombre.'],
                    400
                );

            return response()->json(
                ['message' => $this->blockService->store($data)],
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
     * Updates a single block with its new information
     * @param int $block_id
     * @param Request $request
     * @return Response
     */
    public function update(int $block_id, Request $request): Response
    {
        try {
            $validator = $this->validateBlockData($request);
            if ($validator->fails())
                return response()->json(
                    ['message' => implode('.', $validator->errors()->all())],
                    400
                );

            $data = $validator->validated();

            $block = $this->blockService->getBlock($block_id);

            if (empty($block))
                return response()->json(
                    ['message' => 'El id del bloque no existe'],
                    400
                );

            if (count($block['classrooms']) > $data['maxclassrooms'])
                return response()->json(
                    ['message' => 'La capacidad de ambientes no debe ser menor a la cantidad actual de ambientes pertenecientes al bloque en especifico.'],
                    400
                );

            $max_floor = 0;
            foreach ($block['classrooms'] as $classroom)
                $max_floor = max($max_floor, $classroom['floor']);

            if ($max_floor > $data['maxfloor'])
                return response()->json(
                    ['message' => 'La piso maximo seleccionado debe ser mayor o igual al piso de los ambientes existentes pertenecientes al bloque.'],
                    400
                );

            return response()->json(
                ['message' => $this->blockService->update($data, $block_id)],
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
     * Destroy a single block by its ID
     * @param int $blockId
     * @param Request $request
     * @return Response
     */
    public function destroy(int $blockId, Request $request): Response
    {
        try {
            $block = $this->blockService->getBlock($blockId);

            if (empty($block))
                return response()->json(
                    ['message' => 'El id del bloque no existe'],
                    400
                );

            $enabledClassrooms = $this->classroomService
                ->getDisponibleClassroomsByBlock($blockId);

            if (!empty($enabledClassrooms))
                return response()->json(
                    ['message' => 'Existen los siguientes ambiente habilitados en el bloque: '.implode(',',
                            array_map(
                                function ($classroom) {
                                    return $classroom['name'];
                                }, $enabledClassrooms
                            )
                        )
                    ],
                    400
                );

            return response()->json(
                ['message' => $this->blockService->delete($blockId)],
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
     * Validates the single block data
     * @param Request $request
     * @return mixed
     */
    private function validateBlockData(Request $request)
    {
        return Validator::make($request->all(), [
            'name' => '
                required|
                regex:/^[A-Z0-9\-\. ]+$/',
            'maxfloor' => '
                required|
                integer|
                min:0',
            'maxclassrooms' => '
                required|
                integer|
                min:0',
            'block_status_id' => '
                integer|
                exists:block_statuses,id',
            'faculty_id' => 'integer|exists:faculties,id'
        ], [
            'name.required' => 'El atributo \'nombre\' no debe ser nulo o vacio',
            'name.regex' => 'El nombre solamente puede tener caracteres alfanumericos y \'-\', \'.\', \' \'',

            'maxfloor.required' => 'El atributo \'pisos\' no debe ser nulo o vacio',
            'maxfloor.integer' => 'La \'pisos\' debe ser un valor entero',
            'maxfloor.min' => 'Debe seleccionar una \'pisos\' mayor o igual a 0',

            'maxclassrooms.required' => 'El atributo \'capacidad de ambientes\' no debe ser nulo o vacio',
            'maxclassrooms.integer' => 'El \'capacidad de ambientes\' debe ser un valor entero',
            'maxclassrooms.exists' => 'El \'capacidad de ambientes\' debe ser un numero mayor a 0',

            'block_status_id.integer' => 'El \'estado\' debe ser un valor entero',
            'block_status_id.exists' => 'El \'estado\' debe ser una seleccion valida',

            'faculty_id.integer' => 'La \'facultad\' seleccionada debe ser un valor entero',
            'faculty_id.exists' => 'La \'facultad\' seleccionada debe ser una seleccion valida',            
        ]);
    }
}
