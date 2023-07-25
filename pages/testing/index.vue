<script setup>
import { onMounted, ref } from 'vue'
import crossProductSamples from '@/composables/utils'

const sampleEnteties = ref([
  {
    conditions: [
      {
        species: 'Mouse',
      },
    ],
    externalDBID: '',
    secondaryName: 'Mouse',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_ENTITY',
  },
  {
    conditions: [
      {
        species: 'Hunman',
      },
    ],
    externalDBID: '',
    secondaryName: 'Hunman',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_ENTITY',
  },
])

const sampleTissues = ref([
  {
    conditions: [
      {
        tissue: 'tis1',
      },
    ],
    externalDBID: '',
    secondaryName: 'tis1',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_Sample',
  },
  {
    conditions: [
      {
        tissue: 'tis2',
      },
    ],
    externalDBID: '',
    secondaryName: 'tis2',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_Sample',
  },
])

const crossProduct = ref([])

onMounted(() => {
  crossProduct.value = crossProductSamples(sampleEnteties, sampleTissues)
})
</script>

<template>
  <pre> {{ crossProduct }}</pre>
</template>

<style lang="scss" scoped>

</style>
