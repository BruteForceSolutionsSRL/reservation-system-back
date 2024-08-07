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
        Schema::create('reservations', function (Blueprint $table) {
            $table->id();
            $table->integer('quantity');
            $table->integer('repeat');
            $table->longText('observation')->nullable();
            $table->integer('priority')->default(0);
            $table->date('date');
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->boolean('verified');
            $table->boolean('configuration_flag');
            $table->unsignedBigInteger('reservation_status_id');
            $table->unsignedBigInteger('reservation_reason_id');
            $table->unsignedBigInteger('academic_period_id');
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->foreign('reservation_status_id')
                    ->references('id')
                    ->on('reservation_statuses')
                    ->cascadeOnDelete();
            $table->foreign('reservation_reason_id')
                    ->references('id')
                    ->on('reservation_reasons')
                    ->cascadeOnDelete();
            $table->foreign('academic_period_id')
                    ->references('id')
                    ->on('academic_periods')
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
        Schema::dropIfExists('reservations');
    }
};
