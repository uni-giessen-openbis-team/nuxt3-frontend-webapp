<script setup>
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

const store = useOpenBisStore()
const samples = ref([]) // This will hold your samples data

onMounted(async () => {
  await store.loadV3API()
  samples.value = await store.searchSamples()
})
</script>

<template>
  <v-autocomplete
    v-model="selectedSample"
    :items="samples"
    label="Select a sample"
    item-text="name"
    item-value="value"
    return-object
    @change="selectSample"
  />
</template>

<style lang="scss" scoped>

</style>
