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
        Schema::create('person_reservation_teacher_subject', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('person_reservation_id');
            $table->unsignedBigInteger('teacher_subject_id');
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->foreign('person_reservation_id')
                    ->references('id')
                    ->on('person_reservation')
                    ->cascadeOnDelete();
            $table->foreign('teacher_subject_id')
                    ->references('id')
                    ->on('teacher_subjects')
                    ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('person_reservation_teacher_subject');
    }
};
