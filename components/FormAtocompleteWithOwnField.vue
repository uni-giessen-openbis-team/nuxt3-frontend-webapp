<script setup>
import { computed, ref } from 'vue'

// Initialize the props
const props = defineProps({
  variables: {
    type: Array,
    default: () => [],
  },
})

// Initialize the data
const experimentalVariable = ref([])
const entries = ref([])
let queryTerm = ''

// Define the computed property
const search = computed({
  get: () => queryTerm,
  set: (searchInput) => {
    if (queryTerm !== searchInput) {
      queryTerm = searchInput
      loadEntries()
    }
  },
})

// Define the method
async function loadEntries() {
  if (!props.variables) {
    console.error('variables prop is undefined')
    return
  }

  entries.value = props.variables.filter((v) => {
    if (!v) {
      console.error('An item in variables is undefined')
      return false
    }
    if (!v.name) {
      console.error('An item in variables does not have a name property')
      return false
    }

    return v.name.includes(queryTerm)
  })
}
// Load entries on component creation
onMounted(loadEntries)
</script>

<template>
  <v-autocomplete
    v-model="experimentalVariable"
    v-model:search-input="search"
    :items="entries"
    item-text="name"
    item-value="id"
    return-object
    multiple
    chips
  />
</template>
