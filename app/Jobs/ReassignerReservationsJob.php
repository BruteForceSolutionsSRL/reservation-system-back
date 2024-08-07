<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

use App\Service\ServiceImplementation\{
    ClassroomServiceImpl, 
    ReservationServiceImpl,
    BlockServiceImpl,
    TimeSlotServiceImpl
};

use App\Repositories\{
    ReservationRepository,
    ConstantRepository
};

class ReassignerReservationsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $reservations;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($reservations)
    {
        $this->reservations = $reservations;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $reservationService = new ReservationServiceImpl(); 
        $classroomService = new ClassroomServiceImpl();
        $blockService = new BlockServiceImpl();
        $timeSlotService =  new TimeSlotServiceImpl();

        $reservationRepository = new ReservationRepository();
        $reservationsToRejectAndCancel = [];
        foreach ($this->reservations as $reservation) {            
            $blocks = $blockService->getAllBlocks(); 
            $classrooms = [];
            foreach ($blocks as $block) {
                $timeSlots = $timeSlotService->getTimeSlotsSorted($reservation['time_slots']);
                $possibleAssignation = $classroomService->suggestClassrooms(
                    [
                        'block_id' => $block['block_id'],
                        'quantity' => $reservation['quantity'],
                        'date' => $reservation['date'],
                        'time_slot_ids' => $timeSlots,
                    ]
                );
                if (!empty($possibleAssignation) && is_array($possibleAssignation[0])) {
                    $classrooms = $possibleAssignation;
                    break; 
                }
            }
            if (!empty($classrooms)) {
                $reservationRepository
                    ->detachReservationsClassrooms($reservation['reservation_id']);
                $reservation = $reservationService->assignClassrooms(
                    $reservation['reservation_id'],
                    array_map(
                        function ($classroom) {
                            return $classroom['classroom_id'];
                        },
                        $classrooms
                     )
                );  
                if ($reservation['reservation_status'] !== 'ACEPTADO' && ConstantRepository::getAutomaticReservation()!==0) {
                    $reservationService->accept($reservation['reservation_id'], false);
                }
            } else {
                array_push($reservationsToRejectAndCancel, $reservation);
            }
        }
        $reservationService->cancelAndRejectReservations(
            $reservationsToRejectAndCancel,
            'Se rechazo su reserva, dado que existe un evento/reserva especial que requiere el uso de los ambientes que estaban reservados a su nombre, para informacion mas detallada contacte con el administrador.'
        );
    }
}
