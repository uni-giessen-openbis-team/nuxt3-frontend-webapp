<script setup lang="ts">
import { ref, onMounted } from 'vue'
import type { VocabularyTerm } from '@/types/wizard'

const props = defineProps<{
  list?: VocabularyTerm[]
}>()

const emit = defineEmits<{
  (e: 'update:list', value: VocabularyTerm[]): void
}>()

const textInput = ref('')

onMounted(() => {
  textInput.value = props.list?.map(item => item.title).join('\n') ?? ''
})

function updateValue(newValue: string) {
  const list = newValue.split('\n').filter(item => item.trim() !== '').map(item => ({
    title: item.trim(),
  }))
  emit('update:list', list)
}
</script>

<template>
  <div>
    <v-textarea v-model="textInput" @update:model-value="updateValue" />
  </div>
</template>
