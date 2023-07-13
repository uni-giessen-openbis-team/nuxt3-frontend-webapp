<script setup>
// When making web applications and embedding them into an openBIS tab on the core UI 
// is often required to have information about the context those applications are 
// being loaded for two particular purposes.
// https://unlimited.ethz.ch/display/openBISDoc2010/openBIS+V3+API#openBISV3API-VI.Webapplicationcontext
import { onMounted } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

const store = useOpenBisStore()

onMounted(() => {
  const webappcontext = store.v3.getWebAppContext()
  console.log(webappcontext.getWebappCode())
  console.log(webappcontext.getSessionId())
  console.log(webappcontext.getEntityKind())
  console.log(webappcontext.getEntityType())
  console.log(webappcontext.getEntityIdentifier())
  console.log(webappcontext.getEntityPermId())
})
</script>

<template>
  <div>testing</div>
</template>

<style lang="scss" scoped>

</style>
