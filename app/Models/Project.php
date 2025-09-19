<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model, SoftDeletes};
use Illuminate\Database\Eloquent\Relations\{BelongsTo, HasMany};

class Project extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'title',
        'description',
        'deadline',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'updated_at',
        'deleted_at',
    ];

    protected function createdAt(): Attribute
    {
        return Attribute::make(
            get: fn (string $value) => Carbon::parse($value)->format('M d Y g:iA'),
        );
    }

    protected function deadline(): Attribute
    {
        return Attribute::make(
            get: fn (?string $value) => $value ? Carbon::parse($value)->format('M d Y') : null,
        );
    }

    /**
     * Get the user who created the task.
     *
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * Get the associated tasks.
     *
     * @return HasMany
     */
    public function tasks(): HasMany
    {
        return $this->hasMany(Task::class, 'project_id');
    }

    public function getProjects(array $params): LengthAwarePaginator
    {
        $projects = auth()->user()->projects()
            ->when(isset($params['title']), function ($query) use ($params) {
                $query->where('title', 'LIKE', '%' . $params['title'] . '%');
            })
            ->when(isset($params['description']), function ($query) use ($params) {
                $query->where('description', 'LIKE', '%' . $params['description'] . '%');
            })
            ->when(isset($params['deadline']), function ($query) use ($params) {
                $query->where('deadline', $params['deadline']);
            })
            ->paginate($params['per_page'] ?? config('projects.default_limit'));

        return $projects;
    }


    public function saveUserProject(array $data): void
    {
        if (isset($data['id'])) {
            auth()->user()->projects()->find($data['id'])->update($data);
        } else {
            $taskData = $data + ['user_id' => auth()->id()];
            auth()->user()->projects()->create($taskData);
        }
    }
}
