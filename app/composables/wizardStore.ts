import { defineStore } from 'pinia';
import { EntitySampleHandler, BiologicalSampleHandler, TechnicalSampleHandler } from '~/composables/SampleHandlerClass';

export const useWizardStore = defineStore('wizardStore', {

  state: () => ({
    // create the sampleHandler objects
    spaceId: '',
    projectId: '',
    collectionId: '',

    entitySampleHandler: null as EntitySampleHandler | null,
    biologicalSampleHandler: null as BiologicalSampleHandler | null,
    technicalSampleHandler: null as TechnicalSampleHandler | null,
  }),

  actions: {
    // create the sampleHandler objects
    createSampleHandlers() {
      this.entitySampleHandler = new EntitySampleHandler(this.spaceId, this.projectId, this.collectionId);
      this.biologicalSampleHandler = new BiologicalSampleHandler(this.spaceId, this.projectId, this.collectionId, this.entitySampleHandler);
      this.technicalSampleHandler = new TechnicalSampleHandler(this.spaceId, this.projectId, this.collectionId, this.biologicalSampleHandler);
    } 
  }


});

