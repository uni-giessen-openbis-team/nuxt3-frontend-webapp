<script setup>
import { onMounted, ref, watch } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'
import LoginForm from '@/components/TheLoginForm.vue'

const store = useOpenBisStore()
const showLoginForm = ref(!store.sessionToken)

watch(() => store.sessionToken, (newVal) => {
  if (newVal)
    showLoginForm.value = false
})

onMounted(() => {
  store.loadV3API()
})
</script>

<template>
  <div>
    <LoginForm v-if="showLoginForm" />
    <NuxtLayout v-else>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>
