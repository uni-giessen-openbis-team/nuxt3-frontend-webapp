<script lang="ts" setup>
import TheNavbar from '@/components/TheNavbar.vue'
</script>

<template>
  <v-app>
    <TheNavbar />
    <v-main>
      <slot />
    </v-main>
    <TheFooter />
  </v-app>
</template>
