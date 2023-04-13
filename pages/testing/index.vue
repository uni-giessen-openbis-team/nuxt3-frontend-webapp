<script setup lang="ts">
import { onMounted, reactive } from 'vue'
import { SpaceFetchOptions, SpaceSearchCriteria, openbis } from 'openbis'

const numOfSpaces = reactive({ value: 0 })

onMounted(async () => {
  // Instantiate the AS API
  const v3 = new openbis()

  // Login to obtain a session token
  await v3.login('admin', 'password')

  // Search for spaces
  const result = await v3.searchSpaces(new SpaceSearchCriteria(), new SpaceFetchOptions())

  // Set the number of spaces
  numOfSpaces.value = result.getObjects().length

  // Logout to release the resources related with the session
  await v3.logout()
})
</script>

<template>
  <div>
    <p>Number of spaces: {{ numOfSpaces }}</p>
  </div>
</template>
