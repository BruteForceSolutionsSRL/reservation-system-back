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
        Schema::create('classrooms', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('capacity');
            $table->integer('floor');
            $table->unsignedBigInteger('block_id');
            $table->unsignedBigInteger('classroom_type_id');
            $table->unsignedBigInteger('classroom_status_id'); 
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->foreign('block_id')
                    ->references('id')
                    ->on('blocks')
                    ->cascadeOnDelete();
            $table->foreign('classroom_type_id')
                    ->references('id')
                    ->on('classroom_types')
                    ->cascadeOnDelete();
            $table->foreign('classroom_status_id')
                    ->references('id')
                    ->on('classroom_statuses')
                    ->cascadeOnDelete();
        });
        DB::unprepared('
            create trigger classroom_insert after insert on classrooms
            for each row
            begin
            declare v_block_name varchar (255);
            declare v_classroom_type_name varchar (255);
            declare v_classroom_status_name varchar (255);
        
            select 
                B.name,
                CT.description,
                CS.name
            into
                v_block_name,
                v_classroom_type_name,
                v_classroom_status_name
            from 
                blocks B,
                classroom_types CT, 
                classroom_statuses CS
            where 
                new.block_id = B.id 
                and new.classroom_type_id = CT.id
                and new.classroom_status_id = CS.id;
        
            insert into classroom_logs (
                classroom_id, 
                name, 
                capacity, 
                floor, 
                block_name,
                classroom_type_name,
                classroom_status_name) 
            values (
                new.id,
                new.name,
                new.capacity,
                new.floor,
                v_block_name,
                v_classroom_type_name,
                v_classroom_status_name
            );
            end;
        ');
        DB::unprepared('
            create trigger classroom_update after update on classrooms
            for each row
            begin
            declare v_block_name varchar (255);
            declare v_classroom_type_name varchar (255);
            declare v_classroom_status_name varchar (255);
        
            select 
                B.name,
                CT.description,
                CS.name
            into
                v_block_name,
                v_classroom_type_name,
                v_classroom_status_name
            from 
                blocks B,
                classroom_types CT, 
                classroom_statuses CS
            where 
                new.block_id = B.id 
                and new.classroom_type_id = CT.id
                and new.classroom_status_id = CS.id;
        
            insert into classroom_logs (
                classroom_id, 
                name, 
                capacity, 
                floor, 
                block_name,
                classroom_type_name,
                classroom_status_name) 
            values (
                new.id,
                new.name,
                new.capacity,
                new.floor,
                v_block_name,
                v_classroom_type_name,
                v_classroom_status_name
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
        Schema::dropIfExists('classrooms');
        DB::unprepared('
            drop trigger if exists classroom_insert;
        ');
        DB::unprepared('
            drop trigger if exists classroom_update;
        ');
    }
};
