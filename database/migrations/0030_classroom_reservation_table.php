<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('classroom_reservation', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('classroom_id');
            $table->unsignedBigInteger('reservation_id');
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->foreign('classroom_id')
                    ->references('id')
                    ->on('classrooms')
                    ->cascadeOnDelete();
            $table->foreign('reservation_id')
                    ->references('id')
                    ->on('reservations')
                    ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reservation_classrooms');
    }
};
