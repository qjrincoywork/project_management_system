<?php

namespace App\Http\Controllers;

use App\Enums\TaskStatus;
use App\Http\Requests\TaskCreateRequest;
use App\Http\Requests\TaskListRequest;
use App\Models\Task;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TaskController extends Controller
{
    /**
     * Task model instance.
     *
     * @var Task
     */
    protected $task;

    /**
     * TaskController constructor.
     *
     * @param Task $task
     *
     * @return void
     */
    public function __construct(Task $task) {
        $this->task = $task;
    }

    /**
     * Display a listing of the resource.
     */
    public function index(TaskListRequest $request)
    {
        return Inertia::render('tasks/Index', [
            'tasks' => $this->task->getTasks($request->validated())->items()
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(TaskCreateRequest $request)
    {
        $statuses = TaskStatus::LIST;

        dd($statuses);
        return Inertia::render('tasks/Create', compact('statuses'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Task $task)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Task $task)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Task $task)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Task $task)
    {
        //
    }
}
