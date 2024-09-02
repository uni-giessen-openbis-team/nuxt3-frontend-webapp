
<script setup lang="ts">

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
// For each Experiment, There need to be at least 3 collections. 
// 1. Biological_Entities
// 2. Biological_Samples
// 3. Technical_Sample
const handleCreateCollection = async () => {
  try {
    const typeId = 'DEFAULT_EXPERIMENT'
    await createCollection(collectionContext.value.code, typeId, useWizardStore().projectContext.code as string );
    resetNewCollection();
  } catch (error: any) {
    error.value = 'Failed to create collection. Please try again.';
  }
};

const saveCollection = async () => {
  console.log("🚀 ~ saveCollection ~ collectionContext.value:", collectionContext.value.code);
  await handleCreateCollection();
};
</script>

<template>
  <v-btn color="primary" @click="showModal = true">Add New Collection</v-btn>
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
        <v-spacer/>
        <v-btn @click="showModal = false">Cancel</v-btn>
        <v-btn @click="saveCollection">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

