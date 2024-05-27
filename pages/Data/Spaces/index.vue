<template>
  <h1>Spaces</h1>
  <v-container>
    <v-btn @click="dialog = true" color="primary" class="mb-4">Create New Space</v-btn>

    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="headline">Create New Space</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-text-field v-model="newSpaceCode" label="Space Code" required></v-text-field>
            <v-text-field v-model="newSpaceDescription" label="Description"></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">Cancel</v-btn>
          <v-btn color="blue darken-1" text @click="submitNewSpace">Create</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-row>
      <v-col
        v-for="space in spaces"
        :key="space.permId.permId"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card @click="goToSpace(space.id)" class="space-card">
          <v-card-title>{{ space.code }}</v-card-title>
          <v-card-subtitle>{{ space.description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
    <v-alert v-if="error" type="error">
      {{ error.message }}
    </v-alert>
  </v-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import openbis from '@/composables/openbis.esm';

const spaces = ref<openbis.Space[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const dialog = ref(false)
const newSpaceCode = ref('')
const newSpaceDescription = ref('')
const spaceStore = useSpaceStore()


const fetchSpaces = async () => {
  try {
    spaces.value = await spaceStore.getAllSpaces()
  } catch (err) {
    error.value = err as Error
  }
}

const goToSpace = (permId: string) => {
  router.push(`/data/spaces/${permId}`)
}

const submitNewSpace = async () => {
  if (!newSpaceCode.value) {
    alert("Space Code is required")
    return
  }
  try {
    await spaceStore.createSpace(newSpaceCode.value, newSpaceDescription.value)
    fetchSpaces()
    dialog.value = false
    newSpaceCode.value = ''
    newSpaceDescription.value = ''
  } catch (err) {
    error.value = err as Error
  }
}

onMounted(fetchSpaces)
</script>

<style scoped>
.space-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.space-card:hover {
  transform: scale(1.05);
}
</style>
