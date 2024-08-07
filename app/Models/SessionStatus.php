<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SessionStatus extends Model
{
    use HasFactory;
    protected $table = 'session_statuses';
    
    public function sessions() 
    {
        return $this->hasMany(Sesion::class);
    }
}
