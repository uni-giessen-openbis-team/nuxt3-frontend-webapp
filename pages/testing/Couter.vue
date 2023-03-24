<script setup lang="ts">
const { count } = defineModel < {
  count: number
}>()

function dec() {
  count.value--
}

function inc() {
  count.value++
}
</script>

<template>
  <button
    @click="dec"
  >
    decrease
  </button>

  <button
    @click="inc"
  >
    increase
  </button>
  <div />
</template>

<style scoped>

</style>
