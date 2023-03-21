<script lang="ts" setup>
import TheNavbar from '@/components/TheNavbar.vue'
</script>

<template>
  <v-app>
    <TheNavbar />

    <v-main>
      <v-container>
        <slot />
      </v-container>
    </v-main>

    <footer class="container footer mb-2 mt-auto">
    <!-- <TheFooter /> -->
    </footer>
  </v-app>
</template>
