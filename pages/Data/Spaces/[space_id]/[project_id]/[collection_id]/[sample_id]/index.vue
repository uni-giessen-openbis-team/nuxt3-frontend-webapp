<script setup lang="ts">
import openbis from '@/composables/openbis.esm';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const files = ref<File[]>([]);
const datasets = ref<openbis.DataSet[]>([]);
const route = useRoute();
const sampleId = route.params.sample_id; // Ensure sample_id is correctly set
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
  const dataStoreFacade = useOpenBisStore().v3.getDataStoreFacade();
  try {
    const uploadId = await dataStoreFacade.uploadFilesWorkspaceDSS(files.value); 
    console.log(uploadId);
    var creation = new openbis.UploadedDataSetCreation();
    creation.setUploadId(uploadId);
    creation.setExperimentId(new openbis.ExperimentIdentifier(`${spaceId}/${projectId}/${collectionId}`));
    creation.setTypeId(new openbis.EntityTypePermId("ANALYZED_DATA", openbis.EntityKind.DATA_SET));
    creation.setSampleId(new openbis.SampleIdentifier(sampleId as string)); 

    const dataSetPermId = await dataStoreFacade.createUploadedDataSet(creation);
    console.log("DataSet created with PermId:", dataSetPermId);
  } catch (error) {
    console.error("Request failed:", error);
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
    <!-- <SelectDataSetType :sample="sample" /> -->
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>Upload Data for Sample</v-card-title>
          <v-card-text>
            <v-file-input v-model="files" show-size class="ma-2" multiple @change=" "
              :label="files.length > 0 ? 'Add more files' : 'Choose files'"></v-file-input>
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
