<?php

namespace App\Http\Controllers;

use App\Http\Requests\{ ProjectCreateRequest, ProjectListRequest, ProjectUpdateRequest};
use App\Models\Project;
use Inertia\Inertia;

class ProjectController extends Controller
{
    /**
     * Project model instance.
     *
     * @var Project
     */
    protected $project;

    /**
     * ProjectController constructor.
     *
     * @param Project $project
     *
     * @return void
     */
    public function __construct(Project $project) {
        $this->project = $project;
    }

    /**
     * Display a listing of the resource.
     */
    public function index(ProjectListRequest $request)
    {
        $projects = $this->project->getProjects($request->validated());

        return Inertia::render('projects/Index', ['projects' => $projects->items()]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('projects/Create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ProjectCreateRequest $request)
    {
        $this->project->saveUserProject($request->validated());

        return to_route('projects.index')->with('message', 'Project created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $project = auth()->user()->projects()->findOrFail($id);

        return Inertia::render('projects/Show', compact('project'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(int $id)
    {
        $project = auth()->user()->projects()->findOrFail($id);

        return Inertia::render('projects/Edit', compact('project'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ProjectUpdateRequest $request)
    {
        $this->project->saveUserProject($request->validated());

        return to_route('projects.index')->with('message', 'Project updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        auth()->user()->projects()->find($id)->delete();

        return to_route('projects.index')->with('message', 'Project Deleted.');
    }
}
