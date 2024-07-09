import { defineStore } from 'pinia';
import openbis from '~/composables/openbis.esm';

export const useSampleStore = defineStore('sample', {
  state: () => ({
    samples: [],
    v3: useOpenBisStore().v3
  }),
  actions: {
  

    async listSamplesOfCollection(collectionPermId: string): Promise<openbis.Sample[]> {
      try {
        const criteria = new openbis.SampleSearchCriteria();
        criteria.withExperiment().withPermId().thatEquals(collectionPermId);
        const options = new openbis.SampleFetchOptions();
        const result = await this.v3?.searchSamples(criteria, options);
        return result?.getObjects() || [];
      } catch (error) {
        console.error(`Failed to list samples of collection ${collectionPermId}: ${error}`);
        return [];
      }
    },


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
        const parentSampleCreation = sampleCreationsDict[sample.parent];
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