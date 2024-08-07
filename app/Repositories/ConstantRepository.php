<?php
namespace App\Repositories;

use App\Models\Constant;

class ConstantRepository
{
    protected $model; 
    
    public function __construct()
    {
        $this->model = new Constant();
    }

    public static function getAutomaticReservation()
    {
        return Constant::where('identifier', 'AUTOMATIC_RESERVATION')
            ->get()->first()->value;
    }

    public static function getMaximalReservationPerGroup()
    {
        return Constant::where('identifier', 'MAXIMAL_RESERVATIONS_PER_GROUP')
            ->get()->first()->value;
    }

    /**
     * Update the constant 'AUTOMATIC_RESERVATION'
     * @return void
     */
    public function updateAutomaticReservation()
    {
        $constant = $this->model::where('identifier', 'AUTOMATIC_RESERVATION')
            ->get()->first();
        $constant->value = $constant->value === '1'? '0': '1'; 
        $constant->save();
    }

    /**
     * Update the constant 'MAXIMAL_RESERVATIONS_PER_GROUP'
     * @param array $data
     * @return void
     */
    public function updateMaximalReservationPerGroup(array &$data)
    {
        $constant = $this->model::where('identifier', 'MAXIMAL_RESERVATIONS_PER_GROUP')
            ->get()->first();
        $constant->value = strval($data['quantity']);
        $constant->save(); 
    }

}