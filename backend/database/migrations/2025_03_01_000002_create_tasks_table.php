<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTasksTable extends Migration
{
    public function up()
    {
        Schema::create('tasks', function (Blueprint $table) {
            $table->bigIncrements('id'); // BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY
            $table->unsignedBigInteger('user_id'); // BIGINT UNSIGNED NOT NULL
            $table->string('title', 100); // VARCHAR(100) NOT NULL
            $table->text('description')->nullable(); // TEXT NULL
            $table->enum('status', ['pending', 'completed', 'overdue'])->default('pending'); // ENUM NOT NULL DEFAULT 'pending'
            $table->timestamps(); // Agrega created_at y updated_at manejados por Laravel

            // Clave foránea
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('tasks');
    }
}
