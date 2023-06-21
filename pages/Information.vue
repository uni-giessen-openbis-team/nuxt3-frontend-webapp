<script setup>
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

const store = useOpenBisStore()
const sessionInfo = ref(null)

onMounted(async () => {
  sessionInfo.value = await store.getSessionInformation()
}) 
</script>

<template>
  <h2>Information</h2>
  <div v-if="sessionInfo">
    <p>User Name: {{ sessionInfo.userName }}</p>
    <p>Home Group: {{ sessionInfo.homeGroupCode }}</p>
    <p>Person: {{ sessionInfo.person }}</p>
    <p>Creator Person: {{ sessionInfo.creatorPerson }}</p>
  </div>
  <div v-else>
    <p>Loading session information...</p>
  </div>
</template>

<style lang="scss" scoped>

</style>
