<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TeacherSubject extends Model
{
    use HasFactory;
    protected $table = 'teacher_subjects';

    public function person()
    {
        return $this->belongsTo(Person::class);
    }

    public function universitySubject()
    {
        return $this->belongsTo(UniversitySubject::class);
    }

    public function personReservations()
    {
        return $this->hasMany(PersonReservation::class);
    }

    public function personReservationTeacherSubjects() 
    {
        return $this->hasMany(PersonReservationTeacherSubject::class);
    }
}
