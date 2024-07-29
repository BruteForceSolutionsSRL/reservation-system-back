<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UniversitySubject extends Model
{
    use HasFactory;
    protected $table = 'university_subjects';

    public function teacherSubjects()
    {
        return $this->hasMany(TeacherSubject::class);
    }

    public function studyPlan()
    {
        return $this->belongsToMany(StudyPlan::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class);
    }

    public function studyPlanUniversitySubject()
    {
        return $this->hasMany(StudyPlanUniversitySubject::class);
    }
}
