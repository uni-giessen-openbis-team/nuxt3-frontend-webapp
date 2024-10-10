<script setup lang="ts">
import { ref } from 'vue';
import 'vue3-form-wizard/dist/style.css';


const tab = ref('');

const route = useRoute()

const projectContext = {
  space_id: route.query.space_id as string,
  project_id: route.query.project_id as string,
  collection_id: route.query.collection_id as string,
}

// Select Variables from the List 


</script>



<template>
  <v-container>
    <h2>
      Create new samples for collection {{ projectContext.collection_id }}
    </h2>
    <br>
    <v-tabs v-model="tab" fixed-tabs>
      <v-tab value="Create">
        Create
      </v-tab>
      <v-tab value="Upload">
        Upload
      </v-tab>
    </v-tabs>


    <v-window v-model="tab">
      <v-window-item :key="1" value="Create">
        <WizardStepper />
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input label="File input" multiple chips clearable hint="Select one or more files" persistent-hint />
        </v-form>
      </v-window-item>
    </v-window>
  </v-container>
</template>