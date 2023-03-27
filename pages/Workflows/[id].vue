<script setup lang="ts">
import { nextTick, onMounted, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import type { Version, Workflow } from '@/types/workflow-types'

const dynamicFormValid = ref(false)
const route = useRoute()
const wf_UUID = route.params.id as string
const versions = ref<Version[]>([])
const selectedVersion = ref<Version | undefined>()
const formData = ref<any>({})
const tableData = ref<any[]>([])
const workflows = ref<Workflow[]>([])

// Replace the following with the correct API call to fetch the workflow by UUID
onMounted(async () => {
  try {
    loadVersions(wf_UUID)
    loadWorkflows()
  }
  catch (error) {
    console.error('Error loading workflow:', error)
  }
})

async function loadVersions(wf_UUID: string) {
  try {
    setSelectedVersion(undefined)
    const response = await fetch(
      `http://localhost:3000/workflows_${wf_UUID}_versions`,
    )
    versions.value = await response.json()
    if (versions.value.length === 1)
      setSelectedVersion(versions.value[0])
  }
  catch (error) {
    console.error(`Error loading versions for workflow ${wf_UUID}:`, error)
  }
}

async function setSelectedVersion(version: Version | undefined) {
  selectedVersion.value = undefined
  await nextTick()
  selectedVersion.value = version
}

watch(selectedVersion, () => {
  formData.value = {}
  tableData.value = []
})

// define const

const searchTerm = ref('')

// functions
async function loadWorkflows(): Promise<void> {
  try {
    const response = await fetch('http://localhost:3000/workflows')
    workflows.value = await response.json()
  }
  catch (error) {
    console.error('Error loading workflows:', error)
  }
}

const currentWorkflow = computed(() => {
  const currentWorkflow = workflows.value.find(
    workflow => workflow.UUID === wf_UUID,
  )
  return currentWorkflow
})
</script>

<template>
  <v-container class="bg-surface-variant">
    <div>
      <h1>{{ currentWorkflow?.name.toUpperCase() }}</h1>
      <div>{{ currentWorkflow?.description }}</div>
    </div>
  </v-container>
  <v-container>
    <WorkflowVersionSelector
      v-if="versions.length > 1"
      :versions="versions"
      @version-selected="setSelectedVersion"
    />
    <div v-else-if="versions.length === 1">
      Version: {{ versions[0].name }}
    </div>
    <div v-if="selectedVersion" class="mt-3">
      <div class="parameter-section">
        <h2>Parameter</h2>
        <WorkflowDynamicForm
          v-model:model-value="formData"
          :version="selectedVersion"
          @update:form-valid="dynamicFormValid = $event"
        />
      </div>
      <div class="table-section mt-4">
        <h2>Table</h2>
        <WorkflowTableGenerator
          v-model:table-data="tableData"
          :table-definition="selectedVersion.design_table_definition"
        />
      </div>
    </div>
    <pre>{{ JSON.stringify(formData, null, 2) }}</pre>
    <pre>{{ JSON.stringify(tableData, null, 2) }}</pre>
  </v-container>
</template>
