<script setup lang="ts">
import { ref } from 'vue';
import { FormWizard, TabContent } from 'vue3-form-wizard';
import 'vue3-form-wizard/dist/style.css';

const tab = ref('');
const store = useWizzardStore();

const  {entetyConditionsResult, entetyAndSampleResult, result} = storeToRefs(useWizzardStore())
</script>
 
<template>
  <v-container>
    <v-tabs
      v-model="tab"
      color="deep-purple-accent-4"
      fixed-tabs
    >
      <v-tab value="Create">
        Create
      </v-tab>
      <v-tab value="Upload">
        Upload
      </v-tab>
    </v-tabs>
    <v-window v-model="tab">
      <v-window-item :key="1" value="Create">
        <v-form>
          <FormWizard @on-complete="() => {store.onComplete()}">
            <TabContent title="Project Context">
              <WizzardProjectContext v-model="store.projectContext" />
            </TabContent>
            <TabContent title="Project Enteties" :before-change="store.updateEntety">
              <WizzardProjectEnteties/>
            </TabContent>
            <TabContent title="Entety Preview">
              <WizzardPreviewTable v-model="entetyConditionsResult" />
            </TabContent>
            <TabContent title="Biological Samples" :before-change="store.updateBiol">
              <WizzardSampleExtracts v-model="store.sampleVariables" />
            </TabContent>
            <TabContent title="Biological Samples Preview">
              <WizzardPreviewTable v-model="entetyAndSampleResult" />
            </TabContent>
            <TabContent title="Technical Samples" :before-change="store.updateTech">
              <WizzardTechnical v-model="store.techVariables" />
            </TabContent>
            <TabContent title="Technical Samples Preview">
              <WizzardPreviewTable v-model="result" />
            </TabContent>
          </FormWizard>
        </v-form>
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input
          
            label="File input"
            multiple
            chips
            clearable
            hint="Select one or more files"
            persistent-hint
          />
        </v-form>
      </v-window-item>
    </v-window>
  </v-container>
</template>