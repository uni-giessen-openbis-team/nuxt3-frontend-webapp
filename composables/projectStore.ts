import { defineStore } from 'pinia'
import openbis from '@/composables/openbis.esm'

export const useProjectStore = defineStore('project', {
  state: () => ({
    projects: [] as openbis.Project[]
  }),
  actions: {
    async listProjects(criteria = {}, options = {}): Promise<void> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.searchProjects(
        new openbis.ProjectSearchCriteria().withSpace().withCode().thatEquals("DEFAULT"),
        new openbis.ProjectFetchOptions()
      )
      this.projects = result.objects
    },

    async listProjectsOfSpace(space: { code: string }): Promise<void> {
      const openBisStore = useOpenBisStore()
      const psc = new openbis.ProjectSearchCriteria()
      psc.withSpace().withCode().thatEquals(space.code)
      const result = await openBisStore.v3!.searchProjects(psc, new openbis.ProjectFetchOptions())
      this.projects = result.objects
    },

    async getProject(projectId: string, options = {}) {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.getProjects([new openbis.ProjectPermId(projectId)], new openbis.ProjectFetchOptions(options))
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