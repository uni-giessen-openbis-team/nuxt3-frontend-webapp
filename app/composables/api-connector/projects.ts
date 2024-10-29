import openbis from '../openbis.esm'

async function getProjects(criteria = new openbis.ProjectSearchCriteria(), options = new openbis.ProjectFetchOptions()): Promise<openbis.Project[]> {
  const openBisStore = useOpenBisStore()
  const result = await openBisStore.v3!.searchProjects(criteria, options)
  return result.getObjects()
}

async function getProjectsOfSpace(spaceId: string): Promise<openbis.Project[]> {
  const psc = new openbis.ProjectSearchCriteria()
  psc.withSpace().withCode().thatEquals(spaceId)
  const result = await useOpenBisStore().v3!.searchProjects(psc, new openbis.ProjectFetchOptions())
  return result.getObjects()
}

async function getProjectsOfSpaceCompletely(spaceId: string): Promise<openbis.Project[]> {
  const psc = new openbis.ProjectSearchCriteria()
  psc.withSpace().withCode().thatEquals(spaceId)
  const result = await useOpenBisStore().v3!.searchProjects(psc, fetchProjectCompletely())
  return result.getObjects()
}

async function getProject(projectId: string, options = new openbis.ProjectFetchOptions()): Promise<openbis.Project> {
  const openBisStore = useOpenBisStore()
  const result = await openBisStore.v3!.getProjects(
    [new openbis.ProjectPermId(projectId)],
    options
  )
  return result[projectId]
}

async function getProjectCompletely(projectId: string): Promise<openbis.Project> {
  const openBisStore = useOpenBisStore()
  const result = await openBisStore.v3!.getProjects(
    [new openbis.ProjectPermId(projectId)],
    fetchProjectCompletely()
  )
  return result[0]
}

async function createProject(projectCode: string, spaceCode: string, description?: string): Promise<openbis.ProjectPermId> {
  const openBisStore = useOpenBisStore()
  const creation = new openbis.ProjectCreation()
  creation.setCode(projectCode)
  creation.setSpaceId(new openbis.SpacePermId(spaceCode))
  if (description) {
    creation.setDescription(description)
  }
  const result = await openBisStore.v3!.createProjects([creation])
  return result[0]
}

async function createProjects(projects: openbis.ProjectCreation[]): Promise<openbis.ProjectPermId[]> {
  const openBisStore = useOpenBisStore()
  const result = await openBisStore.v3!.createProjects(projects)
  return result
}

async function createProjectWithCollections(projectCode: string, spaceCode: string, description?: string): Promise<openbis.ProjectPermId> {
  console.log("🚀 ~ createProjectWithCollections ~ projectCode:", projectCode);
  console.log("🚀 ~ createProjectWithCollections ~ spaceCode:", spaceCode);
  console.log("🚀 ~ createProjectWithCollections ~ description:", description);

  try {
    // Create the project first
    const projectPermId = await createProject(projectCode, spaceCode, description);

    // Define the collections to be created with the new project
    const collections = [
      { name: 'Biological_Entities', typeId: 'Q_BIOLOGICAL_ENTITIY' },
      { name: 'Biological_Samples', typeId: 'Q_BIOLOGICAL_SAMPLE' },
      { name: 'Technical_Samples', typeId: 'Q_TECHNICAL_SAMPLE' }
    ];

    // Create each collection linked to the newly created project
    for (const collection of collections) {
      await createCollection(collection.name, collection.typeId, projectPermId.getPermId());
    }

    return projectPermId;
  } catch (error) {
    console.error("Failed to create project with collections:", error);
    throw error; // Rethrow or handle as needed
  }
}

async function updateProject(project: openbis.ProjectUpdate): Promise<void> {
  const openBisStore = useOpenBisStore()
  await openBisStore.v3!.updateProjects([project])
}

async function updateProjects(projects: openbis.ProjectUpdate[]): Promise<void> {
  const openBisStore = useOpenBisStore()
  await openBisStore.v3!.updateProjects(projects)
}

async function deleteProject(projectId: string, reason: string): Promise<void> {
  const openBisStore = useOpenBisStore()
  const pdo = new openbis.ProjectDeletionOptions().setReason(reason)
  await openBisStore.v3!.deleteProjects([new openbis.ProjectPermId(projectId)], pdo)
}

async function getProjectsForSpaces(spaceIds: string[]): Promise<{ [key: string]: openbis.Project[] }> {
  const projects: { [key: string]: openbis.Project[] } = {}

  for (const spaceId of spaceIds) {
    projects[spaceId] = await getProjectsOfSpace(spaceId)
  }

  return projects
}

export {
  getProjects,
  getProjectsOfSpace,
  getProjectsOfSpaceCompletely,
  getProject,
  getProjectCompletely,
  createProject,
  createProjects,
  createProjectWithCollections,
  updateProject,
  updateProjects,
  deleteProject,
  getProjectsForSpaces
}
