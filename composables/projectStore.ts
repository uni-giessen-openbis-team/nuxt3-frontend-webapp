
//ts-nocheck

import { defineStore } from 'pinia'

export const useProjectStore = defineStore('project',{
    state:() => ({
    }),
    actions : {
      async listProjects(criteria = {}, options = {}): Promise<openbis.SearchResult<openbis.Project>>{
        const projects = await useOpenBisStore().v3.searchProjects(
            new openbis.ProjectSearchCriteria(),
            new openbis.ProjectFetchOptions())
        return projects
      },

    async listProjectsOfSpace( space ):Promise<Project[]> {
        const psc = new openbis.ProjectSearchCriteria()
        psc.withSpace().withCode().thatEquals(space.code)
        const result = await useOpenBisStore().v3.searchProjects(psc, new openbis.ProjectFetchOptions())
        return result.objects
    },

      getProject(projectId, options = {}) {
        const result = this.v3.getProjects([new ProjectPermId(projectId)], new ProjectFetchOptions(options))
        return result.get(projectId)
      },

      createProjects(projects) {
        return useOpenBisStore().v3.createProjects(projects)
      },

      updateProject(project) {
        useOpenBisStore().v3.updateProjects([project])
        return true
      },

      updateProjects(projects) {
        useOpenBisStore().v3.updateProjects(projects)

        return true
      },

      deleteProject(projectId, reason) {
        const { ProjectDeletionOptions } = this.loadedResources
        const pdo = new ProjectDeletionOptions().setReason(reason)

        useOpenBisStore().v3.deleteProjects([projectId], pdo)

        return true
      },

    }
})
