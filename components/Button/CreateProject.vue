<script setup lang="ts">
import openbis from '~/composables/openbis.esm';

const showModal = ref(false)

const MINDESCLENGTH = 20;

interface ProjectContext {
  space: openbis.Space | null;
  code: string;
  description: string;
}

const projectContext = ref<ProjectContext>({ 
  space: null,
  code: '',
  description: '',
});

const saveProject = () => {
  console.log("🚀 ~ saveProject ~ projectContext.value:", projectContext.value.code)
  createProject(projectContext.value)
};

async function createProject(project:ProjectContext): Promise<void> {
      // frist create a new empty project
      const newProject = new openbis.ProjectCreation() 
      // fill the project with the necessary info
      newProject.setCode(project.code)
      newProject.setDescription(project.description)
      if (project.space) newProject.setSpaceId(project.space.getPermId())
      useOpenBisStore().v3?.createProjects([newProject])
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
      
      <APIComponentsAutocompleteSpaces
        v-model="projectContext.space"
      /> 
      <v-text-field
        v-model="projectContext.code"
        label="New Project Name"
        :rules="[value => !!value || 'Item is required']"
      />

      <!-- <APIComponentsAutocompletePersons
        v-model="projectContext.contactPerson"
        :space="projectContext.space"
        label="Contact Person"
      />

      <APIComponentsAutocompletePersons
        v-model="projectContext.manager"
        :space="projectContext.space"
        label="Project Manager"
      />  -->

    <v-textarea
      v-model="projectContext.description"
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
