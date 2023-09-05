<script setup lang="ts"> 
import { useOpenBisStore } from '@/composables/openbisAPI'

const store = useOpenBisStore()

const information = await store.listCollections()
</script>

<template>
  <pre>{{ information[0].getSamples()[0] }}</pre>
  <pre>{{ information[0].getSamples()[0].getCode() }}</pre>
</template>
