<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('teacher_subject_logs', function (Blueprint $table) {
            $table->id();
            $table->integer('teacher_subject_id');
            $table->string('person_name');
            $table->string('person_last_name');
            $table->string('group_number'); 
            $table->string('academic_period_name'); 
            $table->string('university_subject_name'); 
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('teacher_subject_logs');
    }
};
