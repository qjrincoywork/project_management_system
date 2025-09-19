<?php

namespace App\Enums;

use BenSampo\Enum\Enum;

/**
 * Represents a task status.
 *
 * This class defines constants for different task statuses, such as TODO, IN_PROGRESS, and DONE.
 * It also provides a constant LIST that contains all the available task statuses.
 */
final class TaskStatus extends Enum
{
    public const TODO = 1;
    public const IN_PROGRESS = 2;
    public const DONE = 3;

    public const LIST = [
        self::TODO,
        self::IN_PROGRESS,
        self::DONE
    ];

    public const LIST_NAME = [
        self::TODO => 'Todo',
        self::IN_PROGRESS => 'In Progress',
        self::DONE => 'Done'
    ];
}
