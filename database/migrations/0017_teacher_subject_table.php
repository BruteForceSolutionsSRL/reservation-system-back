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
        Schema::create('teacher_subjects', function (Blueprint $table) {
            $table->id();
            $table->string('group_number');
            $table->unsignedBigInteger('person_id');
            $table->unsignedBigInteger('university_subject_id');
            $table->unsignedBigInteger('academic_period_id');
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->foreign('person_id')
                    ->references('id')
                    ->on('people')
                    ->cascadeOnDelete();
            $table->foreign('university_subject_id')
                    ->references('id')
                    ->on('university_subjects')
                    ->cascadeOnDelete();
            $table->foreign('academic_period_id')
                    ->references('id')
                    ->on('academic_periods')
                    ->cascadeOnDelete();
        }); 
        DB::unprepared('
            create trigger teacher_subject_insert after insert on teacher_subjects
            for each row
            begin
            declare v_person_name varchar (255);
            declare v_person_last_name varchar (255);
            declare v_academic_period_name varchar (255);
            declare v_university_subject_name varchar (255);
            
            select 
                P.name, 
                P.last_name,
                AP.name,
                US.name
            into
                v_person_name, 
                v_person_last_name,
                v_academic_period_name,
                v_university_subject_name
            from 
                people as P, 
                academic_periods as AP, 
                university_subjects as US
            where 
                new.person_id = P.id 
                and new.academic_period_id = AP.id
                and new.university_subject_id = US.id;
    
            insert into teacher_subject_logs (
                teacher_subject_id,
                person_name, 
                person_last_name, 
                group_number, 
                academic_period_name, 
                university_subject_name
                ) 
            values (
                new.id,
                v_person_name,
                v_person_last_name,
                new.group_number, 
                v_academic_period_name,
                v_university_subject_name
            );
            end;
        ');
        DB::unprepared('
            create trigger teacher_subject_update after update on teacher_subjects
            for each row
            begin
            declare v_person_name varchar (255);
            declare v_person_last_name varchar (255);
            declare v_academic_period_name varchar (255);
            declare v_university_subject_name varchar (255);
            
            select 
                P.name, 
                P.last_name,
                AP.name,
                US.name
            into
                v_person_name, 
                v_person_last_name,
                v_academic_period_name,
                v_university_subject_name
            from 
                people as P, 
                academic_periods as AP, 
                university_subjects as US
            where 
                new.person_id = P.id 
                and new.academic_period_id = AP.id
                and new.university_subject_id = US.id;
    
            insert into teacher_subject_logs (
                teacher_subject_id,
                person_name, 
                person_last_name, 
                group_number, 
                academic_period_name, 
                university_subject_name
                ) 
            values (
                new.id,
                v_person_name,
                v_person_last_name,
                new.group_number, 
                v_academic_period_name,
                v_university_subject_name
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
        Schema::dropIfExists('teacher_subjects');
    }
};