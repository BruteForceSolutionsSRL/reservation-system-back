<?php
namespace App\Repositories;

use App\Models\{
    ReservationReason
};

use Illuminate\Database\Eloquent\Model; 

class ReservationReasonRepository
{
    protected $model; 
    public function __construct()
    {
        $this->model = ReservationReason::class;
    }
    /**
     * Retrieve a list of all reservation reasons formatted
     * @param none
     * @return array 
     */
    public function getAllReservationReason(): array
    {
        return $this->model::all()->map(
            function ($reservationReason) 
            {
                return $this->formatOutput($reservationReason);
            }
        )->toArray();
    }

    /**
     * Transform ReservationReason to array
     * @param ReservationReason $reservationReason
     * @return array
     */
    private function formatOutput(ReservationReason $reservationReason): array
    {
        return [
            'reservation_reason_id' => $reservationReason->id,
            'name' => $reservationReason->reason
        ];
    } 
}