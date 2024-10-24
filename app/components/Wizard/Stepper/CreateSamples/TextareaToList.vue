<script setup lang="ts">
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
  const list = newValue.split('\n').map(item => ({
  title: item, 
  }))
  emit('update:list', list)
}


</script>

<template>
  <div>
    <v-textarea :model-value="textInput" @update:model-value="updateValue" />
  </div>
</template>
