import { defineStore } from 'pinia'
import openbis from '~/composables/openbis.esm'

export const useProjectStore = defineStore('project', {
  state: () => ({
    projects: [] as openbis.Project[],
    projectContext: {} ,
  }),

  actions: {
    async getProjects(criteria = {}, options = {}): Promise<openbis.Project[]> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.searchProjects(
        new openbis.ProjectSearchCriteria(),
        new openbis.ProjectFetchOptions()
      )
      return result.getObjects()
    },

    async getProjectsOfSpace(spaceId: string): Promise<openbis.Project[]> {
      const psc = new openbis.ProjectSearchCriteria()
      psc.withSpace().withCode().thatEquals(spaceId)
      const result = await useOpenBisStore().v3!.searchProjects(psc, new openbis.ProjectFetchOptions())
      return result.getObjects()
    },
    
    async getProjectsOfSpaceCompletely(spaceId: string): Promise<openbis.Project[]> {
      const psc = new openbis.ProjectSearchCriteria()
      psc.withSpace().withCode().thatEquals(spaceId)
      const result = await useOpenBisStore().v3!.searchProjects(psc, fetchProjectCompletely())
      return result.getObjects()
    },

    async getProject(projectId: string, options = {}): Promise<openbis.Project> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.getProjects(
        [new openbis.ProjectPermId(projectId)],
        new openbis.ProjectFetchOptions()
      )
      return result[projectId]
    }, 

    async getProjectCompletely(projectId: string): Promise<openbis.Project> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.getProjects(
        [new openbis.ProjectPermId(projectId)],
        fetchProjectCompletely()
      )
      return result[0]
    },

    async createProject(projectCode: string, spaceCode: string, description?: string): Promise<openbis.ProjectPermId> {
      const openBisStore = useOpenBisStore()
      const creation = new openbis.ProjectCreation()
      creation.setCode(projectCode)
      creation.setSpaceId(new openbis.SpacePermId(spaceCode))
      if (description) {
        creation.setDescription(description)
      }
      const result = await openBisStore.v3!.createProjects([creation])
      return result[0]
    },

    async createProjects(projects: openbis.ProjectCreation[]): Promise<openbis.ProjectPermId[]> {
      const openBisStore = useOpenBisStore()
      const result = await openBisStore.v3!.createProjects(projects)
      return result
    },

    async createProjectWithCollections(projectCode: string, spaceCode: string, description?: string): Promise<openbis.ProjectPermId> {
      console.log("🚀 ~ createProjectWithCollections ~ projectCode:", projectCode);
      console.log("🚀 ~ createProjectWithCollections ~ spaceCode:", spaceCode);
      console.log("🚀 ~ createProjectWithCollections ~ description:", description);

      try {
        // Create the project first
        const projectPermId = await this.createProject(projectCode, spaceCode, description);

        // Define the collections to be created with the new project
        const collections = [
          { name: 'Biological_Entities', typeId: 'Q_BIOLOGICAL_ENTITIY' },
          { name: 'Biological_Samples', typeId: 'Q_BIOLOGICAL_SAMPLE' },
          { name: 'Technical_Samples', typeId: 'Q_TECHNICAL_SAMPLE' }
        ];

        // Create each collection linked to the newly created project
        const collectionStore = useCollectionStore();
        for (const collection of collections) {
          await collectionStore.createCollection(collection.name, collection.typeId, projectPermId.getPermId());
        }

        return projectPermId;
      } catch (error) {
        console.error("Failed to create project with collections:", error);
        throw error; // Rethrow or handle as needed
      }
    },

    async updateProject(project: openbis.ProjectUpdate): Promise<void> {
      const openBisStore = useOpenBisStore()
      await openBisStore.v3!.updateProjects([project])
    },

    async updateProjects(projects: openbis.ProjectUpdate[]): Promise<void> {
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
