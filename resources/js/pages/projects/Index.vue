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
        title: 'Projects',
        href: '/projects',
    },
];
const page = usePage();

defineProps({ projects: { type: Array } });

/**
 * Deletes a project by its id.
 *
 * @param {string} id - The id of the project to be deleted.
 *
 * @returns {void}
 */
function deleteProject(id) {
    if (confirm('Are you sure you want to delete this project?')) {
        // Proceed with deletion
        console.log('Project deleted');
        router.delete(`/projects/${id}`);
    }
}
</script>

<template>
    <Head title="Projects" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div v-if="page.props.flash.message" class="mb-4 rounded-lg bg-green-100 px-6 py-4 text-green-800">
            {{ page.props.flash.message }}
        </div>
        <div class="rounded-xl p-4">
            <!-- Create Project Page -->
            <Link href="/projects/create"><Button class="cursor-pointer">Create Project</Button></Link>
        </div>
        <div>
            <Table>
                <TableCaption>A list of your projects.</TableCaption>
                <TableHeader>
                    <TableRow>
                        <TableHead>
                        ID
                        </TableHead>
                        <TableHead class="w-[100px]">
                        Title
                        </TableHead>
                        <TableHead>Description</TableHead>
                        <TableHead>Deadline</TableHead>
                        <TableHead class="text-right">
                        Action
                        </TableHead>
                    </TableRow>
                </TableHeader>
                <TableBody>
                    <TableRow v-for="project in projects" :key="project.project">
                        <TableCell class="font-medium">{{ project.id }}</TableCell>
                        <TableCell>{{ project.title }}</TableCell>
                        <TableCell>{{ project.description }}</TableCell>
                        <TableCell>{{ project.deadline }}</TableCell>
                        <TableCell class="text-right">
                            <Link :href="`/projects/${project.id}/edit`">
                                <Button class="cursor-pointer ml-2" variant="secondary">Edit</Button>
                            </Link>
                            <Link :href="`/projects/${project.id}`">
                                <Button class="cursor-pointer ml-2" variant="default">Show</Button>
                            </Link>
                            <Button @click="deleteProject(project.id)" class="cursor-pointer ml-2" variant="destructive">Delete</Button>
                        </TableCell>
                    </TableRow>
                </TableBody>
            </Table>
        </div>
    </AppLayout>
</template>
