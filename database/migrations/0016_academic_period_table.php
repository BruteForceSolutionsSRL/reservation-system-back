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
        Schema::create('academic_periods', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->date('initial_date');
            $table->date('end_date');
            $table->date('initial_date_reservations');
            $table->boolean('activated');
            $table->unsignedBigInteger('faculty_id');
            $table->unsignedBigInteger('academic_management_id'); 
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));
        
            $table->foreign('faculty_id')
                    ->references('id')
                    ->on('faculties')
                    ->cascadeOnDelete();
            $table->foreign('academic_management_id')
                    ->references('id')
                    ->on('academic_managements')
                    ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('academic_periods');
    }
};
