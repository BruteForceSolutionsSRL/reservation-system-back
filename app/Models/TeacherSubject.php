<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TeacherSubject extends Model
{
    use HasFactory;

    public function person()
    {
        return $this->belongsTo(Person::class);
    }

    public function universitySubject()
    {
        return $this->belongsTo(UniversitySubject::class);
    }

    public function reservationTeacherSubjects()
    {
        return $this->hasMany(ReservationTeacherSubject::class);
    }

    public function reservations()
    {
        return $this->belongsToMany(Reservation::class);
    }
}
