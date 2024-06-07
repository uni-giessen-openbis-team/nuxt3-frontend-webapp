<script setup lang="ts">
import { ref } from 'vue';

const showModal = ref(false);

const MINDESCLENGTH = 20;

const { spaceId } = defineProps<{ 
  spaceId: string
}>()

const code = ref('');
const description = ref('');

const saveProject = async () => {
  if (!code.value) {
    console.error("Project code cannot be empty.");
    return;
  }
  console.log("🚀 ~ saveProject ~ code:", code.value);
  await createProject();
};

async function createProject(): Promise<void> {
  useProjectStore().createProjectWithCollections(code.value , spaceId , description.value )
}
</script>

<template>
  <v-btn @click="showModal = true" color="primary">Add New Project</v-btn>
  <v-dialog v-model="showModal" max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add New Project</span>
      </v-card-title>
      <v-card-text>
        <ModalCreateProject />
        <v-text-field
          v-model="code"
          label="New Project Name"
          :rules="[value => !!value || 'Item is required']"
        />
        <v-textarea
          v-model="description"
          :counter="2000"
          label="Description"
          :rules="[value => !!value || 'Item is required', value => (value && value.length >= MINDESCLENGTH) || 'Item must be at least 20 characters']"
        />
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn @click="showModal = false">Cancel</v-btn>
        <v-btn @click="saveProject">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
