<script setup lang="ts">
import openbis from '~/composables/openbis.esm';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import type { a } from 'vitest/dist/chunks/suite.BMWOKiTe.js';

const files = ref<File[]>([]);
const datasets = ref<openbis.DataSet[]>([]);
const route = useRoute();
const sampleId = route.params.sample_id; // Ensure sample_id is correctly set

const spaceId = route.params.space_id as string;
const projectId = route.params.project_id as string;
const collectionId = route.params.collection_id as string;

// Function to fetch datasets for a given sample
async function fetchDatasetsForSample() {
  datasets.value = await listDataSetsOfObject(sampleId as string);
}

const sample = ref<openbis.Sample | undefined>(undefined)

onMounted(async () => {
  fetchDatasetsForSample();
  sample.value = await fetchSample(sampleId as string)
});

async function fetchSample(samplePermId: string): Promise<openbis.Sample | undefined>  {
  try {
    const openBisStore = useOpenBisStore()
    const criteria = new openbis.SampleSearchCriteria()
    criteria.withPermId().thatEquals(samplePermId)
    const options = fetchObjectWithParentsAndChildrenRecursive()
    const result = await openBisStore.v3?.searchSamples(criteria, options)
    return result?.getObjects()[0]
  } catch (error) {
    console.error(`Failed to list samples of collection ${samplePermId}: ${error}`)
    return undefined
  }
}

async function uploadFiles() {
  // Ensure there are files selected
  if (files.value.length === 0) {
    console.error("No files selected for upload.");
    return;
  }
  const dataStoreFacade = useOpenBisStore().v3?.getDataStoreFacade();
  // console.log('spaceID', spaceId, 'projectID', projectId, 'collectionID', collectionId, 'sampleID', sampleId);
  try {
    const uploadId = await dataStoreFacade.uploadFilesWorkspaceDSS(files.value); 
    console.log(uploadId);
    const creation = new openbis.UploadedDataSetCreation();
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

  <v-container>
    <h3>Sample: {{ sample?.getCode() }}</h3>
    {{ sample?.get }}
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>Sample Details</v-card-title>
          <v-card-text>
            <div v-if="sample">
              <h4>Parents:</h4>
              <v-list>
                <v-list-item v-for="parent in sample.getParents()" :key="parent.getPermId().toString()">
                  <v-list-item-content>
                    <v-list-item-title>{{ parent.getCode() }}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
              <h4>Children:</h4>
              <v-list>
                <v-list-item v-for="child in sample.getChildren()" :key="child.getPermId().toString()">
                  <v-list-item-content>
                    <v-list-item-title>{{ child.getCode() }}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </div>
            <div v-else>
              <p>No sample data available.</p>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

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
              :label="files.length > 0 ? 'Add more files' : 'Choose files'"
              @change="handleUpload"/>
            <v-btn :disabled="files.length === 0" @click="uploadFiles">Upload</v-btn>
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
