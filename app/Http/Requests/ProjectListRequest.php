<?php

namespace App\Http\Requests;

use App\Enums\{SortOrder, TaskSortTarget, TaskStatus};
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ProjectListRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'title' => [
                'nullable',
                'string',
                'max:100'
            ],
            'description' => [
                'nullable',
                'string',
                'max:255'
            ],
            'deadline' => [
                'nullable',
                'string',
                'max:255'
            ],
            'per_page' => [
                'nullable',
                'integer'
            ],
        ];
    }
}
