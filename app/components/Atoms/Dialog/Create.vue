
<script setup lang="ts">

const dialog = ref(false)
const code = ref('')
const description = ref('')
const error = ref<Error | null>(null)

const props = defineProps<{
	name: string
	createFunction: (code: string, description?: string) => Promise<void>
}>()


const submitNewInstance = async () => {
  if (!code.value) {
    alert("Space Code is required")
    return
  }
  try {
    await props.createFunction(code.value, description.value)
    dialog.value = false
    code.value = ''
    description.value = ''
  } catch (err) {
    error.value = err as Error
  }
}

</script>


<template>
<v-btn color="primary" class="mb-4" @click="dialog = true">Create New {{name}}</v-btn>

<v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="headline">Create New {{name}}</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-text-field v-model="code" label="Space Code" required/>
            <v-text-field v-model="description" label="Description"/>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer/>
          <v-btn @click="dialog = false">Cancel</v-btn>
          <v-btn @click="submitNewInstance">Create</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="headline">Create New {{name}}</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-text-field v-model="code" label="Labbook Name" required/>
            <v-text-field v-model="description" label="Description"/>
          </v-form>
          <v-alert v-if="error" type="error">
               {{ error.message }}
          </v-alert>
        </v-card-text>
     
        <v-card-actions>
          <v-spacer/>
          <v-btn color="blue darken-1" @click="dialog = false">Cancel</v-btn>
          <v-btn color="blue darken-1" @click="submitNewInstance">Create</v-btn>
        </v-card-actions>
    
      </v-card>
    </v-dialog>
</template>
