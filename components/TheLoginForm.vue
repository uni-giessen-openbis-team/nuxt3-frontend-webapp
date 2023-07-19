<script setup>
import { ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'

const username = ref('')
const password = ref('')
const error = ref(null)
const store = useOpenBisStore()

const handleLogin = async () => {
  try {
    await store.login(username.value, password.value)
  }
  catch (e) {
    error.value = e
  }
}
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
