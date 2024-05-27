// sampleStore.ts
import { defineStore } from 'pinia';
import openbis from './openbis.esm';

/* In order to organize metadata in a flexible way, openBIS has introduced 
the concept of Experiment Types, Sample Types, Data Set Types and Material 
Types. At this level, you will assign metadata by using property types.



*/

export const useSampleStore = defineStore('sample', {
  state: () => ({
    samples: [],
    v3: useOpenBisStore().v3
  }),
  actions: {

    createSample(sample, projectContext, sampleCreationsDict) {
        const sampleCreation = new openbis.SampleCreation();
        sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType));
        sampleCreation.setSpaceId(new openbis.SpacePermId(projectContext.space));
     

      // Iterate over conditions and set property for each
      for (const condition of sample.conditions) {
        for (const [key, value] of Object.entries(condition)) {
          sampleCreation.setProperty(key, value);
        }
      }

      if (sample.parent) {
        const pare tSampleCreation = sampleCreationsDict[sample.parent];
        if (parentSampleCreation) {
          sampleCreation.setParentIds([parentSampleCreation.getCreationId()]);

          const parentChildIds = parentSampleCreation.getChildIds() || [];
          parentChildIds.push(sampleCreation.getCreationId());
          parentSampleCreation.setChildIds(parentChildIds);
        } else {
          console.log('Parent sample not found');
        }
      }

      return sampleCreation;
    },
  },
});