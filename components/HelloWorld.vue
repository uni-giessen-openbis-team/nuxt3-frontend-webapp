<script setup lang="ts">
defineProps<{
  text: string
}>()
</script>

<template>
  <div>
    <v-text>
      {{ text }}
    </v-text>
  </div>
</template>
