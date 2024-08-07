<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudyPlanAcademicPeriod extends Model
{
    use HasFactory;
    protected $table = 'study_plan_academic_period'; 

    public function studyPlan() 
    {
        return $this->belongsTo(StudyPlan::class);
    }

    public function academicPeriod()
    {
        return $this->belongsTo(AcademicPeriod::class);
    }
}
