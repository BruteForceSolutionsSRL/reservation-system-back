<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\{
    Schema,
    DB,
};

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('classroom_logs', function (Blueprint $table) {
            $table->id();
            $table->integer('classroom_id');
            $table->string('name'); 
            $table->integer('capacity'); 
            $table->integer('floor'); 
            $table->string('block_name');
            $table->string('classroom_type_name'); 
            $table->string('classroom_status_name'); 
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('classroom_logs');
    }
};
