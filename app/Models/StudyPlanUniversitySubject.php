<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudyPlanUniversitySubject extends Model
{
    use HasFactory;
    protected $table = 'study_plan_university_subject';

    public function studyPlan()
    {
        return $this->belongsTo(StudyPlan::class);
    }

    public function universitySubject()
    {
        $this->belongsTo(UniversitySubject::class);
    }
}
