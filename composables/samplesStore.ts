//ts-nocheck

import { defineStore } from 'pinia'
import openbis from '../openbis-module/openbis.ems'

export const useSampleStore = defineStore('sample',{
    state:() => ({
        samples: [],
        v3:  useOpenBisStore().v3
    }),
    actions: {
        async getSamples(ids, fo) {
            useOpenBisStore().v3.getSamples(ids, fo)
         },

        async createSamplesFromWizzard(projectContext, sampleGroups) {

            const createdSamples = []
            const sampleCreationsDict = {}

            for (const sampleList of sampleGroups) {
            for (const sample of sampleList) {
                const sampleCreation = new openbis.SampleCreation()
                sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType))
                sampleCreation.setSpaceId(new openbis.SpacePermId(projectContext.space))
                sampleCreation.setCreationId(new openbis.CreationId(sample.secondaryName))

                // Iterate over conditions and set property for each
                for (const condition of sample.conditions) {
                for (const [key, value] of Object.entries(condition))
                    sampleCreation.setProperty(key, value)
                }
                // sampleCreation.setCode('MY_SAMPLE_CODE')
                // sampleCreation.setExperimentId(new ExperimentIdentifier('/MY_SPACE_CODE/MY_PROJECT_CODE/MY_EXPERIMENT_CODE'))

                if (sample.parent) {
                // If the sample has a parent, directly get the parent's SampleCreation object from the dictionary
                const parentSampleCreation = sampleCreationsDict[sample.parent]
                if (parentSampleCreation) {
                    sampleCreation.setParentIds([parentSampleCreation.getCreationId()])

                    // Add the sample's creation ID to the parent's child IDs
                    const parentChildIds = parentSampleCreation.getChildIds() || []
                    parentChildIds.push(sampleCreation.getCreationId())
                    parentSampleCreation.setChildIds(parentChildIds)
                }
                else { console.log('Parent sample not found') }
                }

                sample.sampleCreation = sampleCreation
                // Add the SampleCreation object to the dictionary
                sampleCreationsDict[sample.secondaryName] = sampleCreation
                createdSamples.push(sampleCreation)
            }
            }



        return await this.v3.createSamples([createdSamples[0]]).done((permIds) => {
          alert(`Perm ids: ${JSON.stringify(permIds)}`)
        })
        // return createdSamples
      },


 

    }
    }
)



