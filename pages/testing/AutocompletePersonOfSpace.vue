<script setup>
import AutocompletePersonsOfSpace from '~/components/APIComponents/Autocomplete/PersonsOfSpace.vue'
const spaceName = 'DEFAULT'
const person = [{ test: 'test' }]
</script>

<template>
  <AutocompletePersonsOfSpace v-model="person" :space="spaceName" />
</template>

<style lang="scss" scoped>

</style>
