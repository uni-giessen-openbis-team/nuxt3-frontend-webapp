/* 
Experiments are called collections in qportal 

This store is fetching experiment data. 
In this context, an experiment is a sort of collection.
The real experiments are stored in an other store. 
*/

import { defineStore } from 'pinia'
import { fetchExperimentCompletely } from './fetchOptions'



export const useExperimentStore = defineStore('experiment', {
  actions: {
      async listExperiments(criteria :ExperimentSearchCriteria, options : ProjectFetchOptions): Promise<Experiment[]> {
              const result = await useOpenBisStore().v3.searchExperiments(criteria, options)
              return result.objects
      },

      listAllExperiments(): Promise<Experiment[]> {
          return this.listExperiments(new openbis.ExperimentSearchCriteria(), fetchExperimentCompletely())
      },
  
      listExperimentsOfType(typeId:string) :ExperimentSearchCriteria {
        const criteria = new openbis.ExperimentSearchCriteria().withType().withId().thatEquals(typeId)
        return this.listExperiments(criteria)
      },

      listExperimentsOfSpace(space : Space): ExperimentSearchCriteria  {
        const criteria = new openbis.ExperimentSearchCriteria().withProject().withSpace().thatEquals(space.code)
        return this.listExperiments(criteria)
      },

      listExperimentsOfProject(project : Project) {
        const criteria = new openbis.ExperimentSearchCriteria().withProject().withId().thatEquals(project.permId)
        return this.listExperiments(criteria)
      },

      getExperiment(ExperimentId, options = fetchExperimentCompletely()) {
        const result = useOpenbisStore().v3.getExperiments([ExperimentId], options)
        return result.get(ExperimentId)
      },

      getExperiments(ExperimentIds) {
        return useOpenbisStore().v3.getExperiments(ExperimentIds, fetchExperimentCompletely())
      },

      prepareExperimentCreation(ExperimentCode, typeId, projectId, properties = null) {
        const creation = new openbis.ExperimentCreation()
        creation.setCode(ExperimentCode)
        creation.setTypeId(typeId)
        creation.setProjectId(projectId)
        if (properties)
          creation.setProperties(properties)

        return creation
      },

      createExperiment(Experiment:Experiment) {
        return useOpenbisStore().v3.createExperiments([Experiment]).get(0)
      },

      updateExperiment(Experiment : Experiment) {
        const update = new openbis.ExperimentUpdate()
        update.setExperimentId(Experiment.getIdentifier())
        update.setProjectId(Experiment.getProject().getIdentifier())
        update.setProperties(Experiment.getProperties())
        useOpenbisStore().v3.updateExperiments([update])
        return true
      },

      deleteExperiment(ExperimentId, reason) {
        const options = new openbis.ExperimentDeletionOptions().setReason(reason)
        return useOpenbisStore().v3.deleteExperiments([ExperimentId], options)
      },

      deleteExperiments(Experiments : Experiment[], reason) {
        const ExperimentIds = Experiments.map(Experiment => Experiment.getIdentifier())
        const options = new openbis.ExperimentDeletionOptions().setReason(reason)
        return useOpenbisStore().v3.deleteExperiments(ExperimentIds, options)
      },

      deleteExperimentPermanently(ExperimentId, reason) {
        const deletionId = this.deleteExperiment(ExperimentId, reason)
        useOpenbisStore().v3.confirmDeletions([deletionId])
        return true
      },
  }
})
