<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
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
        Schema::create('person_notification', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('person_id'); 
            $table->unsignedBigInteger('notification_id'); 
            $table->integer('readed')->default(DB::raw('0'));
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));
        
            $table->foreign('person_id')
                ->references('id')
                ->on('people')
                ->cascadeOnDelete();
            $table->foreign('notification_id')
                ->references('id')
                ->on('notifications')
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
        Schema::dropIfExists('person_notification');
    }
};
