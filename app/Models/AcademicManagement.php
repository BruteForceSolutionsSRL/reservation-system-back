<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AcademicManagement extends Model
{
    use HasFactory;

    protected $table = 'academic_managements';

    public function academicPeriods()
    {
        return $this->hasMany(AcademicPeriod::class);
    }
}
