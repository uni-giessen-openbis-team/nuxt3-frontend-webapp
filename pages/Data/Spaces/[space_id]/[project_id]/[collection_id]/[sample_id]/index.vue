<script setup lang="ts">
import openbis from '@/composables/openbis.esm';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const files = ref([]);
const datasets = ref<openbis.DataSet[]>([]);
const route = useRoute();
const sampleId = ref(route.params.sample_id); // Ensure sample_id is correctly set
const datasetStore = useDatasetStore();

const spaceId = route.params.space_id as string;
const projectId = route.params.project_id as string;
const collectionId = route.params.collection_id as string;

// Function to fetch datasets for a given sample
async function fetchDatasetsForSample() {
  datasets.value = await datasetStore.listDataSetsOfObject(sampleId.value as string);
}

onMounted(() => {
  fetchDatasetsForSample();
});

async function uploadFiles() {
  // Ensure there are files selected
  if (files.value.length === 0) {
    console.error("No files selected for upload.");
    return;
  }
  try {
    const dataStoreFacade = useOpenBisStore().v3.getDataStoreFacade();
    const uploadId = await dataStoreFacade.createDataSetUpload("ANALYZED_DATA"); // Create upload ID

    // Create a FormData object to hold the files and additional parameters
    const formData = new FormData();
    files.value.forEach(file => formData.append('file', file));
    formData.append('sessionID', sessionToken);
    formData.append('uploadID', uploadId);
    formData.append('dataSetType', 'ANALYZED_DATA');

    // Upload files via the servlet
    const response = await fetch('/datastore_server/store_share_file_upload', {
      method: 'POST',
      body: formData
    });

    if (!response.ok) {
      throw new Error('File upload failed');
    }

    // Create dataset metadata and register the uploaded files
    const creation = new openbis.UploadedDataSetCreation();
    creation.setUploadId(uploadId);
    creation.setExperimentId(new openbis.ExperimentIdentifier(`${spaceId}/${projectId}/${collectionId}`));
    creation.setTypeId(new openbis.EntityTypePermId("ANALYZED_DATA", openbis.EntityKind.DATA_SET));

    const dataSetPermId = await dataStoreFacade.createUploadedDataSet(creation);
    console.log("DataSet created with PermId:", dataSetPermId);
  } catch (error) {
    console.error("Error during file upload or dataset creation:", error);
    if (error.message.includes('ERR_NAME_NOT_RESOLVED')) {
      console.error("Please check your network connection and the server URL.");
    }
  }
}

function handleUpload() {
  // Handle the file upload logic here
  console.log('handleUpload', files.value);
}
</script>

<template>
  {{ sampleId }}
  <v-container>
    <SelectDataSetType :sample="sample" />
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>Upload Data for Sample</v-card-title>
          <v-card-text>
            <v-file-input
              v-model="files"
              show-size
              class="ma-2"
              multiple
              @change="handleUpload"
              :label="files.length > 0 ? 'Add more files' : 'Choose files'"
            ></v-file-input>
            <v-btn @click="uploadFiles" :disabled="files.length === 0">Upload</v-btn>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>Datasets for Sample</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="dataset in datasets" :key="dataset.getPermId().toString()">
                <v-list-item-content>
                  <v-list-item-title>{{ dataset.getCode() }}</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
