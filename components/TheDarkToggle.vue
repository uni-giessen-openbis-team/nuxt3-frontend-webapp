<script setup>
import { useTheme } from 'vuetify'

// dark toggle
const theme = useTheme()
theme.value = () => theme.global.name.value = theme.global.current.value.dark ? 'light' : 'dark'
</script>

<template>
  <v-switch
    v-model="theme.global.name.value"
    label="Mode"
    false-icon="mdi-weather-night"
    true-icon="mdi-white-balance-sunny"
    false-value="myCustomLightTheme"
    true-value="myCustomDarkTheme"
  >
    />
  </v-switch>
</template>

<style scoped>

</style>
