<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import Button from '@/components/ui/button/Button.vue';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Show a Project',
        href: 'projects',
    },
];

const props = defineProps({ project: Object });
</script>

<template>
    <Head title="Show a Project" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="rounded-xl p-4">
            <Link href="/projects"><Button class="cursor-pointer">Back</Button></Link>
        </div>
        <div class="p-4">
            <div>
                <p><strong>Title:</strong> {{ projects.title }}</p>
                <p><strong>Description:</strong> {{ projects.description }}</p>
                <p><strong>Deadline:</strong> {{ projects.deadline }}</p>
            </div>
        </div>
    </AppLayout>
</template>
