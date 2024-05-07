<script setup>
import { ref } from 'vue'
const store = useOpenBisStore()

const testEntry = ref({
  species: 'Hunman',
  genotype: 'gen2',
  externalDBID: '',
  secondaryName: 'Hunman ; gen2',
  count: '1',
})
const test2 = 'test' == 'test3'

async function sampleCreation() {
  console.log('clicked')
  test.value = await store.createSampleEntry(testEntry)
}
</script>

<template>
  <button @click="sampleCreation()">
    createSampleEntry
  </button>
  <pre>{{ test }}</pre>
</template>

<style lang="scss" scoped>

</style>
