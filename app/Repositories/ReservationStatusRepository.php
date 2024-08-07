<?php
namespace App\Repositories;

use App\Models\ReservationStatus; 

use Illuminate\Cache\Repository; 

class ReservationStatusRepository extends Repository
{
     
    protected $model; 
    function __construct() 
    {
        $this->model = ReservationStatus::class;
    }

    /**
     * Retrieve accepted reservation status id
     * @param none
     * @return int
     */
    public static function accepted(): int 
    {   
        return ReservationStatus::where('status', 'ACCEPTED')
            ->orWhere('status', 'ACEPTADO')
            ->first()->id;
    }
    
    /**
     * Retrieve rejected reservation status id
     * @param none
     * @return int
     */
    public static function rejected(): int 
    {
        return ReservationStatus::where('status', 'REJECTED')
            ->orWhere('status', 'RECHAZADO')
            ->first()->id;
    } 

    /**
     * Retrieve pending reservation status id
     * @param none
     * @return int
     */
    public static function pending() : int
    {
        return ReservationStatus::where('status', 'PENDING')
            ->orWhere('status', 'PENDIENTE')
            ->first()->id; 
    }

    /**
     * Retrieve cancelled reservation status id
     * @param none
     * @return int
     */
    public static function cancelled(): int 
    {
        return ReservationStatus::where('status', 'CANCELLED')
            ->orWhere('status', 'CANCELADO')
            ->first()->id;
    }

    /**
     * Retrieve a list of all reservation statuses
     * @param none
     * @return array
     */
    public function getAllReservationStatuses(): array
    {
        return ReservationStatus::select('status', 'id')
                ->get()->map(
                    function ($reservationStatus) 
                    {
                        return $this->formatOutput($reservationStatus);
                    }
                )->toArray();

    }

    /**
     * Transform ReservationStatus to array
     * @param ReservationStatus $reservationStatus
     * @return array
     */
    private function formatOutput(ReservationStatus $reservationStatus): array
    {
        return [
            'reservation_status_id' => $reservationStatus->id,
            'name' => $reservationStatus->status,
        ];
    }
}