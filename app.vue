<script setup>
import { onMounted, ref, watch } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'
import LoginForm from '@/components/TheLoginForm.vue'

const store = useOpenBisStore()
const showLoginForm = ref(!store.isLoggedIn)

watch(() => store.isLoggedIn, (newVal) => {
  if (newVal)
    showLoginForm.value = false
})

onMounted(async () => {
  await store.loadV3API()
})
</script>

<template>
  <div>
    <LoginForm v-if="showLoginForm" />
    <NuxtLayout v-else>
      <TheNavbar />
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>
