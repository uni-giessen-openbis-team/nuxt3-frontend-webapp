<script setup>
function logout() {
  store.logout()
}
</script>

<template>
  <v-button @click="logout">
    Logout
  </v-button>
</template>

<style lang="scss" scoped>

</style>
