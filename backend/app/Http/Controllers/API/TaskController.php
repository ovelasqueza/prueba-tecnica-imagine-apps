<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Task;
use App\Models\User;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index(Request $request)
    {
        $userId = $request->query('user_id');
        $tasks = Task::with('user');
        if ($userId) {
            $tasks = $tasks->where('user_id', $userId);
        }
        return response()->json($tasks->get());
    }

    public function show(Task $task)
    {
        return response()->json($task);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'title' => 'required|string|max:100',
            'description' => 'nullable|string',
        ]);

        $task = Task::create($validated);

        return response()->json(['message' => 'Tarea creada', 'task' => $task], 201);
    }

    public function update(Request $request, $id)
    {
        $task = Task::find($id);
        if (!$task) {
            return response()->json(['message' => 'Tarea no encontrada'], 404);
        }

        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:100',
            'description' => 'nullable|string',
            'status' => 'sometimes|required|in:pending,completed,overdue',
        ]);

        $task->update($validated);

        return response()->json(['message' => 'Tarea actualizada', 'task' => $task]);
    }

    public function destroy($id)
    {
        $task = Task::find($id);
        if (!$task) {
            return response()->json(['message' => 'Tarea no encontrada'], 404);
        }

        $task->delete();

        return response()->json(['message' => 'Tarea eliminada']);
    }
}
