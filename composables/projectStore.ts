import { defineStore } from 'pinia'
import openbis from '@/composables/openbis.esm'

export const useProjectStore = defineStore('project', {
  state: () => ({
    projects: [] as openbis.Project[],
  }),

  actions: {
    async getProjects(criteria = {}, options = {}): Promise<openbis.Project[]> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.searchProjects(
        new openbis.ProjectSearchCriteria(),
        new openbis.ProjectFetchOptions()
      )
      return result.objects
    },

    async getProjectsOfSpace(space: openbis.Space): Promise<openbis.Project[]> {
      const psc = new openbis.ProjectSearchCriteria()
      psc.withSpace().withCode().thatEquals(space.getPermId())
      const result = await useOpenBisStore().v3!.searchProjects(psc, new openbis.ProjectFetchOptions())
      return result.getObjects()
    },

    async getProject(projectId: string, options = {}): Promise<openbis.Project> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.getProjects(
        [new openbis.ProjectPermId(projectId)],
        new openbis.ProjectFetchOptions(options)
      )
      return result.get(projectId)
    },

    async createProjects(projects: openbis.Project[]): Promise<void> {
      const openBisStore = useOpenBisStore()
      await openBisStore.v3!.createProjects(projects)
    },

    async updateProject(project: openbis.Project): Promise<void> {
      const openBisStore = useOpenBisStore()
      await openBisStore.v3!.updateProjects([project])
    },

    async updateProjects(projects: openbis.Project[]): Promise<void> {
      const openBisStore = useOpenBisStore()
      await openBisStore.v3!.updateProjects(projects)
    },

    async deleteProject(projectId: string, reason: string): Promise<void> {
      const openBisStore = useOpenBisStore()
      const pdo = new openbis.ProjectDeletionOptions().setReason(reason)
      await openBisStore.v3!.deleteProjects([new openbis.ProjectPermId(projectId)], pdo)
    },
  },
})
