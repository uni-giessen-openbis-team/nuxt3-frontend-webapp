<script setup lang="ts">
// imports
import { computed, onMounted, ref } from 'vue'
import { useDisplay } from 'vuetify'
import type { Workflow } from '@/types/workflow-types'
const { mdAndUp } = useDisplay()

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
  <v-container>
    <v-row>
      <v-col class="my-3">
        <v-text-field
          v-model="searchTerm"
          label="Search for a workflow"
          single-line
          clearable
          outlined
        />
      </v-col>
      <v-col v-if="mdAndUp">
        <v-spacer />
      </v-col>
    </v-row>

    <v-row class="my-3">
      <v-col
        v-for="(workflow, index) in filteredWorkflows"
        :key="index"
        cols="12"
        sm="6"
        md="4"
      >
        <v-hover
          v-slot="{ isHovering, props }"
          open-delay="0"
        >
          <v-card
            class="mb-4 'on-hover': isHovering"
            :height="200 "
            :elevation="isHovering ? 5 : 2"
            v-bind="props"
          >
            <nuxt-link
              :to="`/workflows/${workflow.UUID}`"
              class="text-decoration-none"
            >
              <v-card-title>{{ workflow.name }}</v-card-title>
              <v-card-text>{{ workflow.description }}</v-card-text>
            </nuxt-link>
          </v-card>
        </v-hover>
      </v-col>
    </v-row>
  </v-container>
</template>
