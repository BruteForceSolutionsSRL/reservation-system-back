<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Classroom extends Model
{
    use HasFactory;
    protected $table = 'classrooms';

    public function block()
    {
        return $this->belongsTo(Block::class);
    }

    public function classroomType()
    {
        return $this->belongsTo(ClassroomType::class);
    }

    public function classroomReservations()
    {
        return $this->hasMany(ClassroomReservation::class);
    }

    public function reservations()
    {
        return $this->belongsToMany(Reservation::class);
    }
    public function classroomStatus()
    {
        return $this->belongsTo(ClassroomStatus::class);
    }
}
