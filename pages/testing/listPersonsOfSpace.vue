<!-- List people from Space -->
<script setup>
import { useOpenBisStore } from '@/composables/openbisAPI'
const store = useOpenBisStore()

const people = ref({})

onMounted(async () => {
  people.value = await store.listPersonsOfSpace('DEFAULT')
})
</script>

<template>
  <pre>

    {{ people }}
  </pre>
</template>

<style lang="scss" scoped>

</style>
