<script setup>
import { onMounted, ref } from 'vue'

const store = useOpenBisStore()
const sessionInfo = ref(null)


</script>

<template>
  <h2>Information</h2>
  <div v-if="sessionInfo">
    <pre>User Name: {{ sessionInfo.userName }}</pre>
    <pre>Home Group: {{ sessionInfo.homeGroupCode }}</pre>
    <pre>Person: {{ sessionInfo.person }}</pre>
    <pre>Creator Person: {{ sessionInfo.creatorPerson }}</pre>
  </div>
  <div v-else>
    <p>Loading session information...</p>
  </div>
</template>

<style lang="scss" scoped>

</style>
