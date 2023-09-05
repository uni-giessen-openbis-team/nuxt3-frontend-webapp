<script setup lang="ts">
import { useOpenBisStore } from '@/composables/openbisAPI'
import { bus } from '@/composables/event-bus'
const { searchTerm } = defineProps<{ searchTerm: string }>()

const forceRerender = ref(0)

const { modelValue } = defineModels<{ modelValue: any }>()
const store = useOpenBisStore()
const speciesList = ref([])

const fetchTerms = async () => {
  const jsonObject = await store.getVocabularyTerms(searchTerm)
  speciesList.value = jsonObject[searchTerm].terms.map(term => term.label)
  console.log('Assigning to speciesList:', speciesList.value)
}
watch(speciesList, (newValue, oldValue) => {
  console.log('speciesList has changed:', newValue)
})
onMounted(fetchTerms)

function updateTermsOnAdd(event: string) {
  console.log('Received event:', event)
  if (event === 'vocabulary-term-added') {
    fetchTerms()
    forceRerender.value++
  }
}

// listen to an event
const unsubscribe = bus.on(updateTermsOnAdd)

// Use onUnmounted to cleanup
onUnmounted(() => {
  unsubscribe()
})

const computedLabel = computed(() => {
  return `Select ${searchTerm}`
})
</script>

<template>
  <v-autocomplete
    :key="forceRerender"
    v-model="modelValue"
    :items="speciesList"
    multiple
    :label="computedLabel "
  />
  <v-spacer />

  <pre
    :key="forceRerender"
  />
</template>
