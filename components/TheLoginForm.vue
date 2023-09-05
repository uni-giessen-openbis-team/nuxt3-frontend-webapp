<script setup>
import { ref, watch } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'

const username = ref('')
const password = ref('')
const error = ref(null)
const store = useOpenBisStore()
const v3 = ref(store.v3)

const handleLogin = async () => {
  try {
    await store.login(username.value, password.value)
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
  <div background-image="@/public/bg-connections.jpg">
    <v-container fluid class="fill-height">
      <v-row
        justify="center"
        align="center"
        class="fill-height"
      >
        <v-col cols="12" sm="8" md="4">
          <v-card class="elevation-12">
            <v-card-title>
              <h2>Login</h2>
            </v-card-title>
            <v-card-text>
              <v-form @submit.prevent="handleLogin">
                <v-text-field
                  v-model="username"
                  label="Username"
                  required
                />

                <v-text-field
                  v-model="password"
                  label="Password"
                  type="password"
                  required
                />
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-spacer />
              <v-btn color="primary" @click="handleLogin">
                Login
              </v-btn>
            </v-card-actions>
            <v-card-actions v-if="error">
              <v-alert type="error" dense>
                Error: {{ error }}
              </v-alert>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<style>
.fill-height {
  height: 100vh;
}
</style>
