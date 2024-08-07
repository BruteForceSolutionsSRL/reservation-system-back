<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TimeSlot extends Model
{
    use HasFactory;
    protected $table = 'time_slots';

    public function reservationTimeSlots()
    {
        return $this->hasMany(ReservationTimeSlot::class);
    }

    public function reservations()
    {
        return $this->belongsToMany(Reservation::class);
    }
}
