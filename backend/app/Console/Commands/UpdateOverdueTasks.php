<?php
namespace App\Console\Commands;
use Illuminate\Console\Command;
use App\Models\Task;

class UpdateOverdueTasks extends Command
{
    protected $signature = 'tasks:update-overdue';
    protected $description = 'Marcar tareas como atrasadas si pasaron su fecha límite';

    public function handle()
    {
        Task::where('deadline', '<', now())
            ->where('status', 'pending')
            ->update(['status' => 'overdue']);

        $this->info('Tareas atrasadas .');
    }
}
