<script setup lang="ts">
// TODO: Gives Request Succeeded, but no gruop gets created.
import { useOpenBisStore } from '@/composables/openbisAPI'
const store = useOpenBisStore()

const creation = store.prepareAuthorizationGroupCreation({ code: 'test3', description: 'The description of the test3 code', userIds: ['1'] })
const test = await store.createAuthorizationGroups(creation)
</script>

<template>
  {{ test }}
</template>
