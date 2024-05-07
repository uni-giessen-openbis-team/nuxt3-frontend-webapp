<script setup>
import { onMounted } from 'vue'
const store = useOpenBisStore()

const test = ref()

const projectContext
    = {
      UUID: '',
      name: '',
      space: 'DEFAULT',
      description: '',
      manager: '',
      contactPerson: '',
    }
const entetyConditionsResult
  = [
    {
      conditions: [
        {
          species: 'Human',
        },
      ],
      externalDBID: '',
      secondaryName: 'Human',
      count: '1',
      sampleType: 'BIOLOGICAL_ENTITY',
    },
  ]
const entetyAndSampleResult
   = [
     {
       conditions: [
         {
           tissue: 'tissue1',
         },
         {
           species: 'Human',
         },
       ],
       externalDBID: '',
       secondaryName: 'Human ; tissue1',
       count: '1',
       sampleType: 'BIOLOGICAL_SAMPLE',
       parent: 'Human',
     },
   ]
const Result
   = [
     {
       conditions: [
         {
           methods: 'DNA',
         },
         {
           tissue: 'tissue1',
         },
         {
           species: 'Human',
         },
       ],
       externalDBID: '',
       secondaryName: 'Human ; tissue1 ; DNA',
       count: '1',
       sampleType: 'TECHNICAL_SAMPLE',
       parent: 'Human ; tissue1',
     },
   ]

onMounted(async () => {
  test.value = await store.createSamplesFromWizzard(projectContext, [entetyConditionsResult, entetyAndSampleResult, Result])
})
</script>

<template>
  <pre> {{ test }}</pre>
</template>

<style lang="scss" scoped>

</style>
