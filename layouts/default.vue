<script lang="ts" setup>
</script>

<template>
  <v-app>
    <VitePwaManifest />
    <TheNavbar />
    <v-main>
      <slot />
    </v-main>
    <TheFooter />
  </v-app>
</template>
