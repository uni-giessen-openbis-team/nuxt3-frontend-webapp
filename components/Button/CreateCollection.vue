<template>
  <v-btn @click="showModal = true" color="primary">Add New Collection</v-btn>
  <v-dialog v-model="showModal" max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add New Collection</span>
      </v-card-title>
      <v-card-text>
        <ModalCreateCollection />
        <v-text-field
          v-model="collectionContext.code"
          label="New Collection Name"
          :rules="[value => !!value || 'Item is required']"
        />
        <v-textarea
          v-model="collectionContext.description"
          :counter="2000"
          label="Description"
          :rules="[value => !!value || 'Item is required', value => (value && value.length >= MINDESCLENGTH) || 'Item must be at least 20 characters']"
        />
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn @click="showModal = false">Cancel</v-btn>
        <v-btn @click="saveCollection">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import openbis from '~/composables/openbis.esm';
import { ref, defineProps } from 'vue';

const props = defineProps<{
  spaceId: string;
  projectId: string;
  collectionId: string;
}>();

const showModal = ref(false);

const MINDESCLENGTH = 20;

interface CollectionContext {
  code: string;
  description: string;
}

const collectionContext = ref<CollectionContext>({
  code: '',
  description: '',
});

// Reset new collection data
const resetNewCollection = () => {
  collectionContext.value = {
    code: '',
    description: ''
  };
};

// Function to create a new collection
const createCollection = async () => {
  try {
    await useCollectionStore().createCollection(props.collectionId, props.projectId, props.spaceId);
    resetNewCollection();
  } catch (error: any) {
    error.value = 'Failed to create collection. Please try again.';
  }
};

const saveCollection = async () => {
  console.log("🚀 ~ saveCollection ~ collectionContext.value:", collectionContext.value.code);
  await createCollection();
};
</script>

<style>
/* Add any specific styles if needed */
</style>