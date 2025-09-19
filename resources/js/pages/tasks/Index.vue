<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import Button from '@/components/ui/button/Button.vue';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";


const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Tasks',
        href: '/tasks',
    },
];
const page = usePage();

defineProps({ tasks: { type: Array } });

/**
 * Deletes a project by its id.
 *
 * @param {string} id - The id of the project to be deleted.
 *
 * @returns {void}
 */
function deleteTask(id) {
    if (confirm('Are you sure you want to delete this task?')) {
        // Proceed with deletion
        console.log('Task deleted');
        router.delete(`/tasks/${id}`);
    }
}
</script>

<template>
    <Head title="Tasks" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div v-if="page.props.flash.message" class="mb-4 rounded-lg bg-green-100 px-6 py-4 text-green-800">
            {{ page.props.flash.message }}
        </div>
        <div class="rounded-xl p-4">
            <!-- Create Task Page -->
            <Link href="/tasks/create"><Button class="cursor-pointer">Create Task</Button></Link>
        </div>
        <div>
            <Table>
                <TableCaption>A list of your tasks.</TableCaption>
                <TableHeader>
                    <TableRow>
                        <TableHead>
                        ID
                        </TableHead>
                        <TableHead class="w-[100px]">
                        Title
                        </TableHead>
                        <TableHead>Status</TableHead>
                        <TableHead>Due Date</TableHead>
                        <TableHead class="text-right">
                        Action
                        </TableHead>
                    </TableRow>
                </TableHeader>
                <TableBody>
                    <TableRow v-for="task in tasks" :key="task.task">
                        <TableCell class="font-medium">{{ task.id }}</TableCell>
                        <TableCell>{{ task.title }}</TableCell>
                        <TableCell>{{ task.description }}</TableCell>
                        <TableCell>{{ task.deadline }}</TableCell>
                        <TableCell class="text-right">
                            <Link :href="`/tasks/${task.id}/edit`">
                                <Button class="cursor-pointer ml-2" variant="secondary">Edit</Button>
                            </Link>
                            <Link :href="`/tasks/${task.id}`">
                                <Button class="cursor-pointer ml-2" variant="default">Show</Button>
                            </Link>
                            <Button @click="deleteTask(task.id)" class="cursor-pointer ml-2" variant="destructive">Delete</Button>
                        </TableCell>
                    </TableRow>
                </TableBody>
            </Table>
        </div>
    </AppLayout>
</template>
