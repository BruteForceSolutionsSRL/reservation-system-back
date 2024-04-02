<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUniversitySubjectsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('university_subjects', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->char('grade');
            $table->dateTime('updated_at');
            $table->dateTime('created_at');
            $table->unsignedBigInteger('career_id');

            $table->foreign('career_id')
                    ->references('id')
                    ->on('careers')
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
        Schema::dropIfExists('university_subjects');
    }
}
