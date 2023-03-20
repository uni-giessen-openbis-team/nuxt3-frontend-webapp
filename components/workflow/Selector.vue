<script setup lang="ts">
import { computed, ref } from 'vue'
import type { Workflow } from './workflow-types'

const props = defineProps<{ workflows: Workflow[] }>()
const searchTerm = ref('')

const filteredWorkflows = computed(() => {
  return props.workflows.filter((workflow) => {
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
      <input
        v-model="searchTerm"
        type="text"
        class="form-control"
        placeholder="Search for a workflow"
      >
    </div>
    <div class="row my-3">
      <div
        v-for="(workflow, index) in filteredWorkflows"
        :key="index"
        class="col-md-4"
      >
        <div class="card mb-4 ">
          <nuxt-link
            :to="`/workflow/${workflow.UUID}` "

            class="text-decoration-none"
          >
            <div class="card-body">
              <h5 class="card-title">
                {{ workflow.name }}
              </h5>
              <p class="card-text">
                {{ workflow.description }}
              </p>
            </div>
          </nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>
