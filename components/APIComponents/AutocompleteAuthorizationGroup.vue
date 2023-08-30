<script setup lang="ts">
import { ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'

const store = useOpenBisStore()
const { modelValue } = defineModels<{ modelValue: any }>()

const authorizationGroups = ref<any[]>([])

authorizationGroups.value = await store.getAuthorizationGroups()
</script>

<template>
  <v-autocomplete
    v-model="modelValue"
    :items="authorizationGroups"
    return-object
    item-title="code"
    label="Authorization Groups"
    :rules="[(value: any) => !!value || 'Item is required']"
  />
  <pre>{{ JSON.stringify(modelValue.permId, null, 2) }}</pre>
</template>
