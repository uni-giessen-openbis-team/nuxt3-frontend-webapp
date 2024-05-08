<script setup>
const store = useOpenBisStore()
const showLoginForm = ref(!store.isLoggedIn)
</script>

<template>
  <div>
    <!-- <LoginForm v-if="showLoginForm" /> -->
    <!-- <TestLogin v-if="showLoginForm" /> -->
    <v-app>
      <v-main>
        <NuxtLayout>
          <TheNavbar />
          <NuxtPage />
        </NuxtLayout>
      </v-main>
      <TheFooter />
    </v-app>
  </div>
</template>
