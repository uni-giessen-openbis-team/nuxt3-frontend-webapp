<template>
  <CreateSpaceDialog
    :dialog="dialog"
    :newSpaceCode="newSpaceCode"
    :newSpaceDescription="newSpaceDescription"
    :submitNewSpace="submitNewSpace"
    :fetchSpaces="fetchSpaces"
    :spaceStore="spaceStore"
    :error="error"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'

import CreateSpaceDialog from '@/components/CreateSpaceDialog.vue'

const submitNewSpace = async () => {
  if (!newSpaceCode.value) {
    alert("Space Code is required")
    return
  }
  try {
    await spaceStore.createSpace(newSpaceCode.value, newSpaceDescription.value)
    fetchSpaces()
    dialog.value = false
    newSpaceCode.value = ''
    newSpaceDescription.value = ''
  } catch (err) {
    error.value = err as Error
  }
}

defineProps({
  dialog: Boolean,
  newSpaceCode: String,
  newSpaceDescription: String,
  submitNewSpace: Function,
  fetchSpaces: Function,
  spaceStore: Object,
  error: Object
})
</script>
