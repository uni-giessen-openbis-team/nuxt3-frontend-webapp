<script lang="ts" setup>
import TheNavbar from '~~/components/TheNavbarBS.vue'
</script>

<template>
  <header class="container">
    <TheNavbar />
  </header>

  <main class="container flex-shrink-0 mb-4">
    <slot />
  </main>

  <footer class="container footer mb-2 mt-auto">
    <!-- <TheFooter /> -->
  </footer>
</template>
