<script setup lang="ts">
import Label from '@/components/ui/label/Label.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import { Input } from "@/components/ui/input";
import { Head, useForm } from '@inertiajs/vue3';
import Button from '@/components/ui/button/Button.vue';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Edit a Project',
        href: 'projects',
    },
];

const props = defineProps({ project: Object });

const form = useForm({
    id: props.project.id,
    title: props.project.title,
    description: props.project.description,
    deadline: props.project.deadline,
});


function updateProject() {
  form.put(`/projects/${props.project.id}`)
}
</script>

<template>
    <Head title="Edit a Project" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="p-4">
            <form @submit.prevent="updateProject" class="w-8/12 space-y-4">
                <div class="space-y-2">
                    <Label for="title">Title</Label>
                    <Input
                        v-model="form.title"
                        id="title"
                        type="text"
                        placeholder="Title"
                    />
                    <p v-if="form.errors.title" class="text-sm text-red-500 mt-1">{{ form.errors.title }}</p>
                </div>
                <div class="space-y-2">
                    <Label for="description">Description</Label>
                    <Input
                        v-model="form.description"
                        id="description"
                        type="text"
                        placeholder="Description"
                    />
                    <p v-if="form.errors.description" class="text-sm text-red-500 mt-1">{{ form.errors.description }}</p>
                </div>
                <div class="space-y-2">
                    <Label for="deadline">Deadline</Label>
                    <Input
                        v-model="form.deadline"
                        id="deadline"
                        type="date"
                        placeholder="Deadline"
                    />
                    <p v-if="form.errors.deadline" class="text-sm text-red-500 mt-1">{{ form.errors.deadline }}</p>
                </div>
                <Button type="submit">Save Project</Button>
            </form>
        </div>
    </AppLayout>
</template>
