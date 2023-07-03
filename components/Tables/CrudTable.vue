<script setup lang="ts">
import { reactive } from 'vue'

const { modelValue } = defineModels<{ modelValue: Element }>()

const newUser = reactive({ name: '' })

function addEntry() {
  modelValue.value.push({ ...newUser })
  newUser.name = ''
  emitUpdate()
}

function deleteUser(index) {
  modelValue.value.splice(index, 1)
  emitUpdate()
}
</script>

<template>
  <div>
    <v-table>
      <thead>
        <tr>
          <th>Entry</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in modelValue.value" :key="index">
          <td>
            <input v-model="user.name" @input="emitUpdate">
          </td>
          <td>
            <button @click="deleteUser(index)">
              <v-icon icon="$delete" />
            </button>
          </td>
        </tr>
      </tbody>
    </v-table>
    <form @submit.prevent="newUser.name && addEntry()">
      <input v-model="newUser.name" placeholder="Enter name">
    </form>
    <pre>{{ modelValue }}</pre>
  </div>
</template>
