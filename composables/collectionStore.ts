import openbis from '@/composables/openbis.esm'
import { defineStore } from 'pinia'
/*
There are 3 Types of collections can be Either Biological Entities, Biological Samples or Technical Samples. 
On the creation of a Experiment these 3 sould be instantiated. 
*/


export const useCollectionStore = defineStore('experiment', {
  actions: {
    async listCollections(criteria = new openbis.ExperimentSearchCriteria(), options = fetchExperimentCompletely()): Promise<openbis.Experiment[]> {
      try {
        const openBisStore = useOpenBisStore()
        const result = await openBisStore.v3?.searchExperiments(criteria, options)
        return result?.getObjects() || []
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`listCollections failed with criteria ${JSON.stringify(criteria)} and options ${JSON.stringify(options)}, returned an empty list.`)
        return []
      }
    },

    async listAllCollections(): Promise<openbis.Experiment[]> {
      return this.listCollections()
    },

    async listCollectionsOfType( typeId: string): Promise<openbis.Experiment[]> {
      const criteria = new openbis.ExperimentSearchCriteria()
      criteria.withType().withCode().thatEquals(typeId)
      return this.listCollections(criteria)
    },

    async listCollectionsOfSpace(space: { code: string }): Promise<openbis.Experiment[]> {
      const criteria = new openbis.ExperimentSearchCriteria()
      criteria.withProject().withSpace().withCode().thatEquals(space.code)
      return this.listCollections(criteria)
    },

    async listCollectionsOfProject(project: openbis.ProjectPermId ): Promise<openbis.Experiment[]> {
      const criteria = new openbis.ExperimentSearchCriteria()
      criteria.withProject().withPermId().thatEquals(project.getPermId())
      return this.listCollections(criteria)
    },

    async getCollection(experimentId: string, options = fetchExperimentCompletely()): Promise<openbis.Experiment | null> {
      try {
        const openBisStore = useOpenBisStore()
        const result = await openBisStore.v3?.getExperiments([new openbis.ExperimentPermId(experimentId)], options)
        if (result && result[experimentId]) {
          return result[experimentId]
        } else {
          console.warn(`getCollection failed with experimentId ${experimentId} and options ${JSON.stringify(options)}, returned null.`)
          return null
        }
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`getCollection failed with experimentId ${experimentId} and options ${JSON.stringify(options)}, returned null.`)
        return null
      }
    },

    async getCollections(experimentIds: string[]): Promise<openbis.Experiment[]> {
      try {
        const openBisStore = useOpenBisStore()
        if (!openBisStore.v3) {
          console.warn(`getCollections failed because openBisStore.v3 is null, returned an empty list.`)
          return []
        }
        const result = await openBisStore.v3.getExperiments(experimentIds.map(id => new openbis.ExperimentPermId(id)), fetchExperimentCompletely())
        return Array.isArray(result) ? result : []
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`getCollections failed with experimentIds ${experimentIds}, returned an empty list.`)
        return []
      }
    },

    prepareCollectionCreation(experimentCode: string, typeId: string, projectId: string, properties: Record<string, string> | null = null): openbis.ExperimentCreation {
      const creation = new openbis.ExperimentCreation()
      creation.setCode(experimentCode)
      creation.setTypeId(new openbis.EntityTypePermId(typeId))
      creation.setProjectId(new openbis.ProjectPermId(projectId))
      if (properties) creation.setProperties(properties)
      return creation
    },

    async createCollection(experimentCode: string, typeId: string, projectId: string, properties: Record<string, string> | null = null): Promise<openbis.ExperimentPermId | null> {
      try {
        console.log("🚀 ~ createCollection ~ experimentCode:", experimentCode);
        console.log("🚀 ~ createCollection ~ typeId:", typeId);
        console.log("🚀 ~ createCollection ~ projectId:", projectId);
        console.log("🚀 ~ createCollection ~ properties:", properties);
        const openBisStore = useOpenBisStore()
        const experiment = this.prepareCollectionCreation(experimentCode, typeId, projectId, properties)
        const result = await openBisStore.v3?.createExperiments([experiment])
        if (result && result.length > 0) {
          return result[0]
        } else {
          console.warn(`createCollection failed with experiment ${JSON.stringify(experiment)}, returned null.`)
          return null
        }
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`createCollection failed with experiment ${JSON.stringify({ experimentCode, typeId, projectId, properties })}, returned null.`)
        return null
      }
    },
    
    async updateCollection(experiment: openbis.Experiment): Promise<boolean> {
      try {
        const openBisStore = useOpenBisStore()
        const update = new openbis.ExperimentUpdate()
        update.setExperimentId(new openbis.ExperimentPermId(experiment.getIdentifier().toString()))
        update.setProjectId(new openbis.ProjectPermId(experiment.getProject().getIdentifier().toString()))
        update.setProperties(experiment.getProperties())
        await openBisStore.v3?.updateExperiments([update])
        return true
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`updateCollection failed with experiment ${JSON.stringify(experiment)}, returned false.`)
        return false
      }
    },

    async deleteCollection(experimentId: string, reason: string): Promise<boolean> {
      try {
        const openBisStore = useOpenBisStore()
        const options = new openbis.ExperimentDeletionOptions()
        options.setReason(reason)
        await openBisStore.v3?.deleteExperiments([new openbis.ExperimentPermId(experimentId)], options)
        return true
      } catch (error:any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteCollection failed with experimentId ${experimentId} and reason ${reason}, returned false.`)
        return false
      }
    },

    async deleteCollections(experiments: openbis.Experiment[], reason: string): Promise<boolean> {
      try {
        const openBisStore = useOpenBisStore()
        const experimentIds = experiments.map(experiment => experiment.getIdentifier())
        const options = new openbis.ExperimentDeletionOptions()
        options.setReason(reason)
        await openBisStore.v3?.deleteExperiments(experimentIds, options)
        return true
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteCollections failed with experiments ${JSON.stringify(experiments)} and reason ${reason}, returned false.`)
        return false
      }
    },

    async deleteCollectionPermanently(experimentId: string, reason: string): Promise<boolean> {
      try {
        const deletionId = await this.deleteCollection(experimentId, reason)
        if (deletionId) {
          const openBisStore = useOpenBisStore()
          await openBisStore.v3?.confirmDeletions([deletionId])
          return true
        }
        return false
      } catch (error: any) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteCollectionPermanently failed with experimentId ${experimentId} and reason ${reason}, returned false.`)
        return false
      }
    }
  }
})
