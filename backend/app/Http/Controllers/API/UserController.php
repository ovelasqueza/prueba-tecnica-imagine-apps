<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        // Devuelve todos los usuarios
        return response()->json(User::all());
    }
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:50',
            'email' => 'required|string|email|max:100|unique:users',
        ]);

        $user = User::create($validated);

        return response()->json(['message' => 'Usuario registrado', 'user' => $user], 201);
    }
}
