import { defineStore } from 'pinia';
import type openbis from './openbis.esm';
import type { Sample } from '@/types/wizard';
import { prepareSampleCreation } from './api-connector/samples';
/**
 * This store is used to manage the samples that are created in the wizard.
 * It is used to prepare the samples for creation in the OpenBis API and to create the samples.
 * The entitySample, biologicalSample and technicalSample are samples that can be salected from a preview page. 
 * If the user selects entitySamples for example, the _entetySamples are translated from the entitySamples to the openbis.Sample[]
 */


export const useWizardStore = defineStore('wizardStore', {
  state: () => ({
    entitySamples: ref<openbis.Sample[]>([]),
    biologicalSamples: ref<openbis.Sample[]>([]),

    _entitySamples: ref<Sample[]>([]),
    _biologicalSamples: ref<Sample[]>([]),
    _technicalSamples: ref<Sample[]>([]),

    spaceId: ref(""),
    projectId: ref(""),
    experimentId: ref(""),
  }),


  actions: {

    // There are three cenarios. 
      // - sample without any entitySamples
      // - sample with entitySamples
      // - sample with biologicalSamples

    translateSamples(samples: openbis.Sample[]): Sample[] { 
      
      const  _samples = [] 
      const _sample = {} as Sample
      samples.forEach(sample => {
        const conditions = sample.getConditions()
        const externalDBID = sample.getExternalDbId()
        const secondaryName = sample.getSecondaryName()
        const sampleType = sample.getSampleType()
        const parent = sample.getParentId()
        _samples.push({conditions, externalDBID, secondaryName, count, sampleType, parent})
      })
      return _samples
    }  
  },



    prepareTechnicalSample(sample: Sample): openbis.SampleCreation {
      return prepareSampleCreation(sample, "Technical", this.spaceId, this.projectId, this.experimentId)
    },
 
    prepareBiologicalSample(sample: Sample): openbis.SampleCreation {
      return prepareSampleCreation(sample, "BIOLOGICAL", this.spaceId, this.projectId, this.experimentId)
    },

    prepareEntitySample(sample: Sample): openbis.SampleCreation {
      return prepareSampleCreation(sample, "ENTITY", this.spaceId, this.projectId, this.experimentId)
    },

    async createSamples() {
      const technicalSamples = this._technicalSamples.map(sample => this.prepareTechnicalSample(sample));
      const biologicalSamples = this._biologicalSamples.map(sample => this.prepareBiologicalSample(sample));
      const entitySamples = this._entitySamples.map(sample => this.prepareEntitySample(sample));
      const allSamples = await Promise.all([...technicalSamples, ...biologicalSamples, ...entitySamples]);
      useOpenBisStore().v3?.createSamples(allSamples);
    },
  }
);

