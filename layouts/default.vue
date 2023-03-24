<script lang="ts" setup>
import { useDisplay } from 'vuetify'
import TheNavbar from '@/components/TheNavbar.vue'
const { name } = useDisplay()
</script>

<template>
  <v-app>
    <TheNavbar />
    <v-main>
      <v-container>
        <slot />
      </v-container>
    </v-main>
    <TheFooter  />
  </v-app>
</template>
