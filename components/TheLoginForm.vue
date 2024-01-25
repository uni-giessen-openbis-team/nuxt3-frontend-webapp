<script setup>
import { ref, watch } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'

const username = ref('')
const password = ref('')
const error = ref(null)
const store = useOpenBisStore()
const v3 = store.v3

const handleLogin = async () => {
  try {
    console.log("login")
    store.login(username.value, password.value)
    console.log("logged in")
  }
  catch (e) {
    error.value = e
  }
}

const autoLogin = async () => {
  username.value = 'admin'
  password.value = 'changeit'
  await handleLogin()
}

watch(v3, (newVal) => {
  if (newVal)
    autoLogin()
}, { deep: true })
</script>

<template>
  <div>
    <h2>Login</h2>
    <form @submit.prevent="handleLogin">
      <label>
        Username:
        <input v-model="username" type="text" required>
      </label>
      <br>
      <label>
        Password:
        <input v-model="password" type="password" required>
      </label>
      <br>
      <button type="submit">
        Log in
      </button>
    </form>
    <div v-if="error">
      <p>Error: {{ error }}</p>
    </div>
  </div>
</template>
