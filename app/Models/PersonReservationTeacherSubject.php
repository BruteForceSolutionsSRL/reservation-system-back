<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PersonReservationTeacherSubject extends Model
{
    use HasFactory;
    protected $table = 'person_reservation_teacher_subject';

    public function personReservation()
    {
        return $this->belongsTo(PersonReservation::class);
    }
    public function teacherSubject()
    {
        return $this->belongsTo(TeacherSubject::class);
    }
}
