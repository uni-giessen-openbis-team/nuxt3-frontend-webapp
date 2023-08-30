<script setup lang="ts">
import { useOpenBisStore } from '@/composables/openbisAPI'

const store = useOpenBisStore()

const information = await store.getRoleAssignments('1')
</script>

<template>
  <pre>{{ information }}</pre>
</template>
