<script setup lang="ts">
import { onMounted, ref } from 'vue'
import type { Workflow } from '@/components/types/workflow-types'
import WorkflowSelector from '@/components/WorkflowSelector.vue'

const workflows = ref<Workflow[]>([])

onMounted(async () => {
  try {
    const response = await fetch('http://localhost:3000/workflows')
    workflows.value = await response.json()
  }
  catch (error) {
    console.error('Error loading workflows:', error)
  }
})
</script>

<template>
  <h1>Workflows</h1>
  <div>Here you can select a workflow for your data</div>
  <WorkflowSelector :workflows="workflows" />
</template>
