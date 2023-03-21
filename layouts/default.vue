<script lang="ts" setup>
import { useDisplay } from 'vuetify'
import TheNavbar from '@/components/TheNavbar.vue'
const { name } = useDisplay()
</script>

<template>
  <v-app>
    <TheNavbar />
    {{ name }}
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
