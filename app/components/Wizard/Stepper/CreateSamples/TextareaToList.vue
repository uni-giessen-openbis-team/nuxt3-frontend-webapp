<script setup lang="ts">
import { computed,  ref, watchEffect } from 'vue'
import type { VocabularyTerm } from '@/types/wizard'

const emit = defineEmits<{
  (e: 'update:list', value: VocabularyTerm[]): void
}>()
const textInput = ref('')

const list = computed<VocabularyTerm[]>(() => textInput.value.split('\n').map(item => ({
  title: item, 
})))

watchEffect(() => {
    emit('update:list', list.value)
  })
 
</script>

<template>
  <div>
    <v-textarea v-model="textInput" />
  </div>
</template>

