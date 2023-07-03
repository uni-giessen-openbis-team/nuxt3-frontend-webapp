<script setup>
import { onMounted } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

const store = useOpenBisStore()
const projectSample = ref([]) // Populate with your data

onMounted(async () => {
  const SampleSearchCriteria = store.loadedResources.SampleSearchCriteria
  const SampleFetchOptions = store.loadedResources.SampleFetchOptions

  // now you can use SpaceSearchCriteria and SpaceFetchOptions
  const criteria = new SampleSearchCriteria()
  const fo = new SampleFetchOptions()
  fo.withProperties()

  const samples = await store.searchSamples(criteria, fo)
  projectSample.value = samples.objects.map(sample => ({
    code: sample.code,
    properties: sample.properties, // Assuming `properties` is the correct key for the sample properties
  }))
})
</script>

<template>
  <div> n
    <h1>Samples:</h1>
    <ul>
      <li v-for="sample in projectSample" :key="sample.code">
        {{ sample.code }}
        <ul>
          <li v-for="(value, key) in sample.properties" :key="key">
            {{ key }}: {{ value }}
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>
