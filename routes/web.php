<?php

use App\Http\Controllers\{ProjectController, TaskController, UserController};
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome');
})->name('home');

Route::get('dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::resource('users', UserController::class);
    Route::resource('projects', ProjectController::class);
    Route::resource('tasks', TaskController::class);
});
// Route::resource('users', UserController::class)->middleware(['auth', 'verified']);
// Route::resource('projects', ProjectController::class)->middleware(['auth', 'verified']);
// Route::resource('tasks', TaskController::class)->middleware(['auth', 'verified']);

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
