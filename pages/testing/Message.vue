<script setup lang="ts">
const { msg } = defineModel<{
  msg: string
}>()
</script>

<template>
  <span>{{ msg }}</span>
  <div>
    <input v-model="msg" type="text">
  </div>
</template>
