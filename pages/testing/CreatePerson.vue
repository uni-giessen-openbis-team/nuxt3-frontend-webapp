<script setup lang="ts">
// TODO: Test it
import { useOpenBisStore } from '@/composables/openbisAPI'
const store = useOpenBisStore()

const creation = ref({})

onMounted(async () => {
  creation.value = await store.preparePersonCreation('12345', 'DEFAULT')
  await store.createPerson(creation)
})
</script>

<template>
  <pre>{{ creation }}</pre>
</template>

<style lang="scss" scoped>

</style>
