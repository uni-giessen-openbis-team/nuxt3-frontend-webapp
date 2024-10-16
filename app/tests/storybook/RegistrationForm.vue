
<script setup lang="ts">
import { ref } from 'vue';

const email = ref('');
const password = ref('');

function handleSubmit() {
  console.log('Form submitted with:', { email: email.value, password: password.value });
  // Add your form submission logic here
}
</script>

<template>
    <form @submit.prevent="handleSubmit">
      <div>
        <label for="email">Email:</label>
        <input id="email" v-model="email" type="email" aria-label="email" required >
      </div>
      <div>
        <label for="password">Password:</label>
        <input id="password" v-model="password" type="password" aria-label="password" required >
      </div>
      <button type="submit" aria-label="submit">Register</button>
    </form>
  </template>

<style scoped>
form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

label {
  font-weight: bold;
}

input {
  padding: 0.5rem;
  font-size: 1rem;
}

button {
  padding: 0.5rem;
  font-size: 1rem;
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</template>
  