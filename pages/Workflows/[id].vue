<script setup lang="ts">
import { nextTick, onMounted, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import type { Version } from '@/components/types/workflow-types'
import VersionSelector from '@/components/WorkflowVersionSelector.vue'
import FormGenerator from '@/components/WorkflowFormGenerator.vue'
import TableGenerator from '@/components/WorkflowTableGenerator.vue'

const route = useRoute()
const wf_UUID = route.params.id as string
const versions = ref<Version[]>([])
const selectedVersion = ref<Version | undefined>()
const formData = ref<any>({})
const tableData = ref<any[]>([])

// Replace the following with the correct API call to fetch the workflow by UUID
onMounted(async () => {
  try {
    loadVersions(wf_UUID)
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
</script>

<template>
  <div>
    <h1>Workflow Data</h1>
  </div>
  <div>
    <VersionSelector
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
        <FormGenerator v-model="formData" :version="selectedVersion" />
      </div>
      <div class="table-section mt-4">
        <h2>Table</h2>
        <TableGenerator
          v-model="tableData"
          :table-definition="selectedVersion.design_table_definition"
        />
      </div>
    </div>
    <details>
      <summary>Form data</summary>
      <pre>{{ JSON.stringify(formData, null, 2) }}</pre>
    </details>
    <details>
      <summary>table data</summary>
      <pre>{{ JSON.stringify(tableData, null, 2) }}</pre>
    </details>
  </div>
</template>
