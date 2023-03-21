<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import type { Workflow } from './workflow-types'

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

const searchTerm = ref('')

const filteredWorkflows = computed(() => {
  return workflows.value.filter((workflow) => {
    const searchValue = searchTerm.value.toLowerCase()
    return (
      workflow.name.toLowerCase().includes(searchValue)
      || workflow.description.toLowerCase().includes(searchValue)
    )
  })
})
</script>

<template>
  <div>
    <div class="my-3">
      <v-text-field
        v-model="searchTerm"
        label="Search for a workflow"
        single-line
        clearable
        outlined
      />
    </div>
    <v-row class="my-3">
      <v-col
        v-for="(workflow, index) in filteredWorkflows"
        :key="index"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card class="mb-4">
          <nuxt-link
            :to="`/workflows/${workflow.UUID}`"
            class="text-decoration-none"
          >
            <v-card-title>{{ workflow.name }}</v-card-title>
            <v-card-text>{{ workflow.description }}</v-card-text>
          </nuxt-link>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>
