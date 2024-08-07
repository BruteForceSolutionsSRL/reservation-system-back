<?php
namespace App\Service\ServiceImplementation;

use App\Repositories\{
    BlockRepository,
    BlockLogRepository,
    BlockStatusRepository,
    PersonRepository, 
    NotificationTypeRepository
};

use App\Repositories\ReservationRepository;
use App\Repositories\ReservationStatusRepository;
use App\Service\{
    BlockService
};

use Carbon\Carbon;

class BlockServiceImpl implements BlockService
{
    private $blockRepository; 
    private $blockLogRepository; 
    private $blockStatusRepository;
    private $reservationRepository; 

    private $classroomService; 
    private $mailService; 
    private $notificationService;
    public function __construct()
    {
        $this->blockRepository = new BlockRepository();
        $this->blockLogRepository = new BlockLogRepository();
        $this->blockStatusRepository = new BlockStatusRepository();
        $this->reservationRepository = new ReservationRepository();

        $this->classroomService = new ClassroomServiceImpl();
        $this->mailService = new MailerServiceImpl();
        $this->notificationService = new NotificationServiceImpl();
    }

    /**
     * Retrieves a list of all blocks 
     * @param none
     * @return array
     */
    public function getAllBlocks(): array
    {
        return $this->blockRepository->getAllBlocks();
    }

    /**
     * Retrieve blocks by a set of faculties
     * @param array $faculties
     * @return array
     */
    public function getBlocksByFaculties(array $faculties): array 
    {
        return $this->blockRepository->getBlocks([
            'faculty_ids' => $faculties,
        ]);
    }
    
    /**
     * Retrieve a single Block using its ID
     * @param int $id
     * @return array
     */
    public function getBlock(int $id): array
    {
        return $this->blockRepository->getBlock($id); 
    }

    /**
     * Retrieve a block within its statistics based on reservations by classrooms
     * @param int $block_id
     * @return array
     */
    public function getBlockStatistics(int $block_id): array 
    {
        $result = [
            'accepted' => 0, 
            'rejected' => 0, 
            'cancelled' => 0, 
            'pending' => 0
        ];
        $classrooms = $this->classroomService->getClassroomsByBlock($block_id); 

        $data = [
            'date_start' => Carbon::parse('0001-01-01'),
            'date_end' => Carbon::now()->addMonths(6),
            'classroom_id' => -1,
        ];

        foreach ($classrooms as $classroom) {
            $data['classroom_id'] = $classroom['classroom_id'];
            $chart = $this->classroomService
                ->getClassroomStats($data);
            if ($chart === []) continue;
            $chart = $chart['chart'];
            for ($i = 0; $i<count($chart); $i++) {
                $set = (array)$chart[$i];
                $result['accepted'] += $set['accepted'];
                $result['rejected'] += $set['rejected']; 
                $result['cancelled'] += $set['cancelled'];
                $result['pending'] += $set['pending']; 
            }
        }
        $result['total'] = $result['accepted']+$result['rejected']+$result['cancelled']+$result['pending'];
        return array_merge($result, $this->getBlock($block_id));
    }

    /**
     * Find a block by its name
     * @param string $name
     * @return array
     */
    public function findByName(string $name): array 
    {
        return $this->blockRepository->findByName($name);
    }

    /**
     * Register a block enabled by default
     * @param array $data
     * @return string
     */
    public function store(array $data): string 
    {
        $data['block_status_id'] = BlockStatusRepository::enabled(); 
        $block = $this->blockRepository->save($data);
        
        $data['title'] = 'CREACION DE BLOQUE #'.$block['block_id'];
        $data['sended'] = 1;
        $data['sendBy'] = PersonRepository::system();
        $data['to'] = ['TODOS']; 
        $data['type'] = NotificationTypeRepository::informative();
        $data['body'] = 'Se creo un nuevo bloque denominado '.$block['name'];

        $emailData = $this->notificationService->store($data);
        $emailData = array_merge($emailData, $block);

        $this->mailService->sendCreationBlockEmail($emailData);

        return 'Se guardo correctamente el nuevo bloque '.$data['name'];
    }

    /**
     * Update a single block registered, with the new information
     * @param array $data
     * @param int $block_id
     */
    public function update(array $data, int $blockId): string 
    {
        $block = $this->blockRepository->update($data, $blockId);
        if ($data['block_status_id'] ==  BlockStatusRepository::disabled()) {
            foreach ($block['classrooms'] as $classroom) {
                $this->classroomService->disable($classroom['classroom_id']);
            }
        }
        
        $data['title'] = 'ACTUALIZACION DE DATOS DEL BLOQUE '.$block['name'].'#'.$block['block_id'];
        $data['sended'] = 1;
        $data['sendBy'] = PersonRepository::system();
        $data['to'] = ['TODOS']; 
        $data['type'] = NotificationTypeRepository::informative();
        $data['body'] = 'Se actualizo el bloque denominado '.$data['name'];

        $emailData = $this->notificationService->store($data);
        $emailData = array_merge($emailData, $block);

        $this->mailService->sendUpdateBlockEmail($emailData);

        return 'Se modifico correctamente el bloque '.$block['name'];
    }

    /**
     * Delete a block within its id
     * @param int $blockId
     * @return string
     */
    public function delete(int $blockId): string 
    {
        $classrooms = array_map(
            function ($classroom) 
            {
                return $classroom['classroom_id'];
            },
            $this->classroomService
                ->getAllClassroomsByBlock($blockId)
        );
        $block = $this->blockRepository->delete($blockId); 

        foreach ($classrooms as $classroomId)
            $this->classroomService->deleteByClassroomId($classroomId);
        
        $data['title'] = 'ELIMINACION DE BLOQUE '.$block['name'].'#'.$block['block_id'];
        $data['sended'] = 1;
        $data['sendBy'] = PersonRepository::system();
        $data['to'] = ['TODOS']; 
        $data['type'] = NotificationTypeRepository::informative();
        $data['body'] = 'Se elimino el bloque denominado '.$block['name'];

        $emailData = $this->notificationService->store($data);
        $emailData = array_merge($emailData, $block);

        $this->mailService->sendDeleteBlockEmail($emailData);

        return 'Se elimino el bloque '.$block['name']; 
    }

    /**
     * Function list all blocks within number of classrooms requested by each block
     * @param array $data
     * @return array 
     */
    public function listBlocksForSpecialReservation(array $data): array 
    {
        $blocks = $this->getAllBlocks(); 
        foreach ($blocks as &$block) {
            $classrooms = array_map(
                function ($classroom) {
                    return $classroom['classroom_id'];
                },
                $block['classrooms']
            );           
            $block['requested'] = count(
                $this->reservationRepository->getReservations(
                    [
                        'dates' => [
                            'date_start' => $data['date_start'],
                            'date_end' => $data['date_end']
                        ],
                        'time_slots' => $data['time_slot_ids'],
                        'classrooms' => $classrooms,
                        'reservation_statuses' => [
                            ReservationStatusRepository::accepted(), 
                            ReservationStatusRepository::rejected()
                        ],
                        'academic_period' => $data['academic_period_id'],
                    ]
                )
            ); 
        }
        return $blocks;
    }

    /**
     * Suggest best blocks by quantity, dates and time slots to do a special reservation
     * @param array $data
     * @return array
     */
    public function suggestBlocks(array $data): array 
    {
        $blocks = $this->listBlocksForSpecialReservation($data);
        foreach ($blocks as &$block) {
            $block['capacity'] = 0; 
            foreach ($block['classrooms'] as $classroom)
                $block['capacity'] += $classroom['capacity'];
        }

        $INF = 1e6+1; 
        $MAX_LEN = 1e5; 
        $dp = array_fill(0, $MAX_LEN, $INF); 
        $auxiliar = array_fill(0, $MAX_LEN, array()); 
        $dp[0] = 0;
        foreach ($blocks as $block)
        for ($i = $MAX_LEN - 1; $i >= 0; $i--) {
            $j = $i+$block['capacity']; 
            if (($j < $MAX_LEN) && ($dp[$j] > $dp[$i] + $block['requested'])) {
                $dp[$j] = $dp[$i]+$block['requested'];
                $auxiliar[$j] = $auxiliar[$i]; 
                array_push($auxiliar[$j], $block); 
            }
        }
        $bestSuggest = -1;
        for ($i = $data['quantity']; ($i < $MAX_LEN) && ($bestSuggest == -1); $i++) {
            if ($dp[$i] < $INF) {
                $bestSuggest = $i;
            }   
        }

        if ($bestSuggest == -1) return ['No existe una sugerencia apropiada para la reserva especial.'];
        return $auxiliar[$bestSuggest];
    }
}