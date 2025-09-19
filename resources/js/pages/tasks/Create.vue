<script setup lang="ts">
import Label from '@/components/ui/label/Label.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import { Input } from "@/components/ui/input";
import { Head, useForm } from '@inertiajs/vue3';
import Button from '@/components/ui/button/Button.vue';
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Create a Task',
        href: '/tasks/create',
    },
];

const form = useForm({
    title: '',
    description: '',
    deadline: '',
});

defineProps({ statuses: { type: Array } });
</script>

<template>
    <Head title="Create a Task" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="p-4">
            <form @submit.prevent="form.post('/tasks')" class="w-8/12 space-y-4">
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
                    <Label for="status">Status</Label>
                      <Select>
                        <SelectTrigger>
                            <SelectValue placeholder="Select Status" />
                        </SelectTrigger>
                        <!-- <SelectContent>
                            <SelectLabel>Status</SelectLabel>
                            <SelectGroup v-for="status in statuses">
                                <SelectItem value="apple">
                                Apple
                                </SelectItem>
                            </SelectGroup>
                        </SelectContent> -->
                    </Select>
                    <p v-if="form.errors.status" class="text-sm text-red-500 mt-1">{{ form.errors.status }}</p>
                </div>
                <div class="space-y-2">
                    <Label for="due_date">Due Date</Label>
                    <Input
                        v-model="form.due_date"
                        id="due_date"
                        type="date"
                        placeholder="Due Date"
                    />
                    <p v-if="form.errors.due_date" class="text-sm text-red-500 mt-1">{{ form.errors.deadline }}</p>
                </div>
                <Button type="submit">Save Task</Button>
            </form>
        </div>
    </AppLayout>
</template>
