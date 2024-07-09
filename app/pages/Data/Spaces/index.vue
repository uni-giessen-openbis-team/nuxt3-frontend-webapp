<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import type openbis from '~/composables/openbis.esm';


const spaces = ref<openbis.Space[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const newSpaceCode = ref('')
const dialog = ref(false)
const newSpaceDescription = ref('')
const spaceStore = useSpaceStore()


// TODO: add a new category for settings 
// Hide the settings space from the user

const inventoryList = ['entity_information','materials', 'methods', 'publications', 'storage', 'user_key_space', 'settings', 'stock_orders', 'stock_catalog', 'eln_settings']

const inventorySpaces = computed(() => {
  return spaces.value.filter(space => inventoryList.includes(space.getCode().toLowerCase()))
})

const labNotebookSpaces = computed(() => {
  return spaces.value.filter(space => !inventoryList.includes(space.getCode().toLowerCase()))
})

const fetchSpaces = async () => {
  try {
    spaces.value = await spaceStore.getAllSpaces()
    // log the spaces
    console.log(spaces.value)
  } catch (err) {
    error.value = err as Error
  }
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

<template>
  <v-container>
    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="headline">Create New Space</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-text-field v-model="newSpaceCode" label="Space Code" required/>
            <v-text-field v-model="newSpaceDescription" label="Description"/>

          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer/>
          <v-btn color="blue darken-1" @click="dialog = false">Cancel</v-btn>
          <v-btn color="blue darken-1" @click="submitNewSpace">Create</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="headline">Create New Space</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-text-field v-model="newSpaceCode" label="Space Code" required/>
            <v-text-field v-model="newSpaceDescription" label="Description"/>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer/>
          <v-btn color="blue darken-1" @click="dialog = false">Cancel</v-btn>
          <v-btn color="blue darken-1" @click="submitNewSpace">Create</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-container>
      <section style="background-color: #e3f2fd;" class="p-4 "> <!-- Light blue background -->
        <h2>
          <v-icon color="green">mdi-book-open-page-variant</v-icon> <!-- Icon for Lab Notebook -->
          Lab Notebook
        </h2>
        <v-row>
          <v-col v-for="space in labNotebookSpaces" :key="space.getPermId().toString()" cols="12" sm="6" md="4">
            <v-card class="space-card" @click="() => router.push(`/data/spaces/${space.getPermId()}`)">
              <v-card-title>{{ space.getCode() }}</v-card-title>
              <v-card-subtitle>{{ space.getDescription() }}</v-card-subtitle>
            </v-card>
          </v-col>
        </v-row>
      </section>

    </v-container>
    <v-alert v-if="error" type="error">
      {{ error.message }}
    </v-alert>
    <br>
    <v-btn color="primary" class="mb-4" @click="dialog = true">Create New Space</v-btn>

  </v-container>

</template>

<style scoped>
.space-card {
  cursor: pointer;
  transition: transform 0.2s;
}

.space-card:hover {
  transform: scale(1.05);
}
</style>
