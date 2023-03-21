<script setup lang="ts">
// imports
import { computed, onMounted, ref } from 'vue'
import type { Workflow } from './workflow-types'
// eslint-disable-next-line vue/no-export-in-script-setup

// define const
const workflows = ref<Workflow[]>([])
const searchTerm = ref('')

// functions
async function loadData(): Promise<void> {
  try {
    const response = await fetch('http://localhost:3000/workflows')
    workflows.value = await response.json()
  }
  catch (error) {
    console.error('Error loading workflows:', error)
  }
}

// computed variables
const filteredWorkflows = computed(() => {
  return workflows.value.filter((workflow) => {
    const searchValue = searchTerm.value.toLowerCase()
    return (
      workflow.name.toLowerCase().includes(searchValue)
      || workflow.description.toLowerCase().includes(searchValue)
    )
  })
})

// lifecircle hook
onMounted(loadData)
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
