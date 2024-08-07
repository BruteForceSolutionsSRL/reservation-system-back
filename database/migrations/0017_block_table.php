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
        Schema::create('blocks', function (Blueprint $table) {
            $table->id();
            $table->integer('max_floor');
            $table->string('name');
            $table->integer('max_classrooms');
            $table->unsignedBigInteger('block_status_id');
            $table->unsignedBigInteger('faculty_id');
            
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));
        
            $table->foreign('block_status_id')
                ->references('id')
                ->on('block_statuses')
                ->cascadeOnDelete();
            $table->foreign('faculty_id')
                ->references('id')
                ->on('faculties')
                ->cascadeOnDelete();
        });
        DB::unprepared('
            create trigger block_insert after insert on blocks
            for each row
            begin
            declare v_block_status_name varchar (255);
        
            select 
                B.name
            into
                v_block_status_name
            from 
                block_statuses B
            where 
                new.block_status_id = B.id; 
        
            insert into block_logs (
                block_id, 
                name, 
                max_floor, 
                max_classrooms,
                block_status_name) 
            values (
                new.id,
                new.name,
                new.max_floor,
                new.max_classrooms,
                v_block_status_name
            );
            end;
        ');
        DB::unprepared('
            create trigger block_update after update on blocks
            for each row
            begin
            declare v_block_status_name varchar (255);
        
            select 
                B.name
            into
                v_block_status_name
            from 
                block_statuses B
            where 
                new.block_status_id = B.id; 
        
            insert into block_logs (
                block_id, 
                name, 
                max_floor, 
                max_classrooms,
                block_status_name) 
            values (
                new.id,
                new.name,
                new.max_floor,
                new.max_classrooms,
                v_block_status_name
            );
            end;
        '); 

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('blocks');
        DB::unprepared('
            drop trigger if exists block_insert;
        ');
        DB::unprepared('
            drop trigger if exists block_update;
        ');
    }
};
