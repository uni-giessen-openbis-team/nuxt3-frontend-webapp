/* 
Experiments are called collections in qportal 

This store is fetching experiment data. 
In this context, an experiment is a sort of collection.
The real experiments are stored in an other store. 
*/import openbis from '@/composables/openbis.esm'
import { defineStore } from 'pinia'


export const useCollectionStore = defineStore('experiment', {
  actions: {
    async listCollections(criteria = new openbis.ExperimentSearchCriteria(), options = fetchExperimentCompletely()): Promise<openbis.Experiment[]> {
      try {
        const openBisStore = useOpenBisStore()
        const result = await openBisStore.v3.searchExperiments(criteria, options)
        return result.getObjects()
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`listExperiments failed with criteria ${criteria} and options ${options}, returned an empty list.`)
        return []
      }
    },

    async listAllCollections(): Promise<openbis.Experiment[]> {
      return this.listCollections()
    },

    async listCollectionsOfType(typeId: string): Promise<openbis.Experiment[]> {
      const criteria = new openbis.ExperimentSearchCriteria()
      criteria.withType().withId().thatEquals(typeId)
      return this.listCollections(criteria)
    },

    async listCollectionsOfSpace(space: { code: string }): Promise<openbis.Experiment[]> {
      const criteria = new openbis.ExperimentSearchCriteria()
      criteria.withProject().withSpace().withCode().thatEquals(space.code)
      return this.listCollections(criteria)
    },

    async listCollectionsOfProject(project: { permId: string }): Promise<openbis.Experiment[]> {
      const criteria = new openbis.ExperimentSearchCriteria()
      criteria.withProject().withId().thatEquals(project.permId)
      return this.listCollections(criteria)
    },

    async getCollection(experimentId: string, options = fetchExperimentCompletely()): Promise<openbis.Experiment | null> {
      try {
        const openBisStore = useOpenBisStore()
        const result = await openBisStore.v3.getExperiments([new openbis.ExperimentPermId(experimentId)], options)
        return result.get(experimentId) || null
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`getExperiment failed with experimentId ${experimentId} and options ${options}, returned null.`)
        return null
      }
    },

    async getCollections(experimentIds: string[]): Promise<openbis.Experiment[]> {
      try {
        const openBisStore = useOpenBisStore()
        const result = await openBisStore.v3.getExperiments(experimentIds.map(id => new openbis.ExperimentPermId(id)), fetchExperimentCompletely())
        return result
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`getExperiments failed with experimentIds ${experimentIds}, returned an empty list.`)
        return []
      }
    },

    prepareCollectionCreation(experimentCode: string, typeId: string, projectId: string, properties: Record<string, string> | null = null): openbis.ExperimentCreation {
      const creation = new openbis.ExperimentCreation()
      creation.setCode(experimentCode)
      creation.setTypeId(new openbis.EntityTypePermId(typeId))
      creation.setProjectId(new openbis.ProjectIdentifier(projectId))
      if (properties) creation.setProperties(properties)
      return creation
    },

    async createCollection(experiment: openbis.ExperimentCreation): Promise<openbis.ExperimentPermId | null> {
      try {
        const openBisStore = useOpenBisStore()
        const result = await openBisStore.v3.createExperiments([experiment])
        return result[0]
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`createExperiment failed with experiment ${experiment}, returned null.`)
        return null
      }
    },

    async updateCollection(experiment: openbis.Experiment): Promise<boolean> {
      try {
        const openBisStore = useOpenBisStore()
        const update = new openbis.ExperimentUpdate()
        update.setExperimentId(new openbis.ExperimentPermId(experiment.getIdentifier()))
        update.setProjectId(new openbis.ProjectIdentifier(experiment.getProject().getIdentifier()))
        update.setProperties(experiment.getProperties())
        await openBisStore.v3.updateExperiments([update])
        return true
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`updateExperiment failed with experiment ${experiment}, returned false.`)
        return false
      }
    },

    async deleteCollection(experimentId: string, reason: string): Promise<boolean> {
      try {
        const openBisStore = useOpenBisStore()
        const options = new openbis.ExperimentDeletionOptions()
        options.setReason(reason)
        await openBisStore.v3.deleteExperiments([new openbis.ExperimentPermId(experimentId)], options)
        return true
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteExperiment failed with experimentId ${experimentId} and reason ${reason}, returned false.`)
        return false
      }
    },

    async deleteCollections(experiments: openbis.Experiment[], reason: string): Promise<boolean> {
      try {
        const openBisStore = useOpenBisStore()
        const experimentIds = experiments.map(experiment => new openbis.ExperimentPermId(experiment.getIdentifier()))
        const options = new openbis.ExperimentDeletionOptions()
        options.setReason(reason)
        await openBisStore.v3.deleteExperiments(experimentIds, options)
        return true
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteExperiments failed with experiments ${experiments} and reason ${reason}, returned false.`)
        return false
      }
    },

    async deleteCollectionPermanently(experimentId: string, reason: string): Promise<boolean> {
      try {
        const deletionId = await this.deleteExperiment(experimentId, reason)
        if (deletionId) {
          const openBisStore = useOpenBisStore()
          await openBisStore.v3.confirmDeletions([deletionId])
          return true
        }
        return false
      } catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteExperimentPermanently failed with experimentId ${experimentId} and reason ${reason}, returned false.`)
        return false
      }
    }
  }
})