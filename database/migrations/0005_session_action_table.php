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
        Schema::create('session_action', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('action_id');
            $table->unsignedBigInteger('session_id');
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));
    
            $table->foreign('action_id')
                    ->references('id')
                    ->on('actions')
                    ->cascadeOnDelete();
            $table->foreign('session_id')
                    ->references('id')
                    ->on('sesions')
                    ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('session_action');
    }
};
