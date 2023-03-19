<script setup lang="ts">
import { ref, toRefs } from 'vue'
import type { Version } from '@/components/types/workflow-types'

const props = defineProps<{ versions: Version[] }>()
const emit = defineEmits<{
  (e: 'versionSelected', v: Version | undefined): void
}>()
const { versions } = toRefs(props)

const selectedVersion = ref<Version>()

async function emitChange() {
  emit('versionSelected', selectedVersion.value)
}
</script>

<template>
  <div>
    <label for="version-select" class="form-label">Select a version:</label>
    <select
      id="version-select"
      v-model="selectedVersion"
      class="form-select"
      @change="emitChange"
    >
      <option v-for="version in versions" :key="version.UUID" :value="version">
        <div class="card text-truncate">
          {{ version.name }}
        </div>
      </option>
    </select>
  </div>
</template>

<style scoped>
.card {
  display: inline-block;
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
