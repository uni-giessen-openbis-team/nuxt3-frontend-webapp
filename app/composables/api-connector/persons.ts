import openbis from '../openbis.esm'

async function listPersons(criteria: openbis.PersonSearchCriteria, options: openbis.PersonFetchOptions) {
  try {
    const openBisStore = useOpenBisStore()
    const persons = await openBisStore.v3?.searchPersons(criteria, options)
    return persons?.getObjects() || []
  }
  catch (error) {
    console.error(error)
    return []
  }
}

async function listPersonsWithCriteria( criteria: openbis.PersonSearchCriteria ) {
  return listPersons(criteria, fetchPersonCompletely())
}

async function listPersonsOfSpace(space: openbis.Space): Promise<openbis.Person[]> {
  try {
    const criteria = new openbis.RoleAssignmentSearchCriteria()
    criteria.withSpace().withCode().thatEquals(space.getCode())

    const fetchOptions = new openbis.RoleAssignmentFetchOptions()
    fetchOptions.withUser()
    fetchOptions.withSpace()

    const openBisStore = useOpenBisStore()
    if (!openBisStore || !openBisStore.v3) {
      throw new Error("OpenBisStore or v3 is not defined.")
    }

    const listOfPers: openbis.SearchResult<openbis.RoleAssignment> | undefined = await openBisStore.v3.searchRoleAssignments(criteria, fetchOptions)

    if (!listOfPers) {
      console.warn(`listPersonsOfSpace(${space}) returned an undefined result.`)
      return []
    }

    return listOfPers.getObjects().map(roleAssignment => roleAssignment.getUser())
  } catch (error: unknown) {
    if (error instanceof Error) {
      console.error(`${error.constructor.name}: ${error.message}`)
    } else {
      console.error('An unknown error occurred')
    }
    console.warn(`listPersonsOfSpace(${space.getCode()}) failed and returned an empty list.`)
    return []
  }
}

async function listPersonsOfProject(project: openbis.Project): Promise<openbis.Person[]> {
  const criteria = new openbis.RoleAssignmentSearchCriteria().withOrOperator()
  criteria.withProject().withId().thatEquals(project.getIdentifier())
  criteria.withSpace().withId().thatEquals(project.getSpace().getPermId())
  const openBisStore = useOpenBisStore()
  const results = await openBisStore.v3?.searchRoleAssignments(
    criteria,
    fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
  )

  const projectMembers = new Set() // No duplicates
  results?.getObjects().forEach((ra) => {
    if (openbis.Role.OBSERVER.equals(ra.getRole()) || (openbis.RoleLevel.INSTANCE.equals(ra.getRoleLevel()) && openbis.Role.ADMIN.equals(ra.getRole())))
      return
    if (ra.getUser() != null)
      projectMembers.add(ra.getUser())
    else
      ra.getAuthorizationGroup().getUsers().forEach(user => projectMembers.add(user))
  })

  return Array.from(projectMembers)
}

async function listPersonsOfProjectById(projectId: string): Promise<openbis.Person[]> {
  const projectStore = useProjectStore()
  const project = await projectStore.getProject(projectId)
  return listPersonsOfProject(project)
}

async function getPerson({ userId, options = fetchPersonCompletely() }) {
  const openBisStore = useOpenBisStore()
  const result = await openBisStore.v3?.getPersons(
    [userId],
    options,
  )
  return result?.get(userId)
}

function preparePersonCreation({ userId, spaceId }): openbis.PersonCreation {
  const creation = new openbis.PersonCreation()
  creation.setUserId(userId)
  if (spaceId)
    creation.setSpaceId(spaceId)
  return creation
}

async function createPerson(creation: openbis.PersonCreation) {
  const openBisStore = useOpenBisStore()
  const result = await openBisStore.v3?.createPersons([creation])
  return result?.[0]
}

async function isPersonAdmin({ personId, userId, person, spaceId, projectId }) {
  const openBisStore = useOpenBisStore()
  if (personId || userId) {
    const { PersonPermId, PersonSearchCriteria, Role, RoleLevel } = openbis
    personId = personId || new PersonPermId(userId)
    const criteria = new PersonSearchCriteria()
    criteria.withId().thatEquals(personId)
    const persons = await openBisStore.v3?.searchPersons(
      criteria,
      fetchPersonCompletely(), 
    )

    if (persons?.getTotalCount() < 1)
      throw new Error(`Could not find person with user id: ${personId}`)

    for (const role of persons.getObjects()[0].getRoleAssignments()) {
      if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
        return true
    }
  }

  if (person) {
    try {
      const { Role, RoleLevel } = openbis

      for (const role of person.getRoleAssignments()) {
        if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
          return true
      }
    }
    catch (error) {
      return isPersonAdmin({ personId: person.getPermId() })
    }
  }

  if (spaceId || projectId) {
    if (await isPersonAdmin({ personId }))
      return true

    const { RoleAssignmentSearchCriteria, Role, RoleLevel } = openbis
    const criteria = new RoleAssignmentSearchCriteria()
    criteria.withSpace().withId().thatEquals(spaceId)
    criteria.withProject().withId().thatEquals(projectId)

    const result = await openBisStore.v3?.searchRoleAssignments(
      criteria,
      fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
    )

    for (const roleAssignment of result?.getObjects() || []) {
      if (roleAssignment.getRole() === Role.ADMIN && roleAssignment.getRoleLevel() === RoleLevel.SPACE) {
        if (roleAssignment.getUser() && roleAssignment.getUser().getPermId().equals(personId))
          return true

        if (roleAssignment.getAuthorizationGroup() && roleAssignment.getAuthorizationGroup().getUsers().map(user => user.getPermId()).includes(personId))
          return true
      }
    }
  }

  return false
}

async function listRoleAssignments({ criteria, options }) {
  try {
    const openBisStore = useOpenBisStore()
    const result = await openBisStore.v3.searchRoleAssignments(criteria, options)
    return result.getObjects()
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`listRoleAssignments(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
    return []
  }
}

async function getRoleAssignment({ roleAssignmentId, options }) {
  try {
    const openBisStore = useOpenBisStore()
    const result = await openBisStore.v3.getRoleAssignments([roleAssignmentId], options)
    return result.get(roleAssignmentId)
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`getRoleAssignment(<TOKEN>,${roleAssignmentId},${options}) failed and returned null.`)
    return null
  }
}

async function getRoleAssignments({ roleAssignmentIds }) {
  try {
    const openBisStore = useOpenBisStore()
    return await openBisStore.v3.getRoleAssignments(roleAssignmentIds, fetchRoleAssignmentCompletely())
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`getRoleAssignments(<TOKEN>,${roleAssignmentIds}) failed and returned null.`)
    return null
  }
}

function prepareRoleAssignmentCreation({ role, spaceId, projectId, userId, authorizationGroupId }) {
  const creation = new openbis.RoleAssignmentCreation()
  creation.setRole(role)
  creation.setSpaceId(spaceId || null)
  creation.setProjectId(projectId || null)
  creation.setUserId(userId || null)
  creation.setAuthorizationGroupId(authorizationGroupId || null)
  return creation
}

async function createRoleAssignment({ creation }) {
  try {
    const openBisStore = useOpenBisStore()
    return (await openBisStore.v3.createRoleAssignments([creation]))[0]
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`createRoleAssignment(<TOKEN>,${creation}) failed and returned null.`)
    return null
  }
}

async function createRoleAssignments({ creations }) {
  try {
    const openBisStore = useOpenBisStore()
    return await openBisStore.v3.createRoleAssignments(creations)
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`createRoleAssignments(<TOKEN>,${creations}) failed and returned null.`)
    return null
  }
}

async function deleteRoleAssignment({ roleAssignmentId, reason }) {
  try {
    const openBisStore = useOpenBisStore()
    const options = new openbis.RoleAssignmentDeletionOptions().setReason(reason)
    await openBisStore.v3.deleteRoleAssignments([roleAssignmentId], options)
    return true
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`deleteRoleAssignment(<TOKEN>,${roleAssignmentId},${reason}) failed and returned false.`)
    return false
  }
}

async function getAuthorizationGroups({
  criteria = new openbis.AuthorizationGroupSearchCriteria(),
  options = fetchAuthorizationGroupCompletely(),
  authorizationGroupId,
} = {}) {
  try {
    const openBisStore = useOpenBisStore()
    if (authorizationGroupId) {
      let result
      if (Array.isArray(authorizationGroupId)) {
        result = await openBisStore.v3.getAuthorizationGroups(
          authorizationGroupId,
          options,
        )
      }
      else {
        result = await openBisStore.v3.getAuthorizationGroups(
          [authorizationGroupId],
          options,
        )
        result = result.get(authorizationGroupId)
      }
      return result
    }
    else {
      const result = await openBisStore.v3.searchAuthorizationGroups(criteria, options)
      return result.getObjects()
    }
  }
  catch (e) {
    console.error(`${e.constructor.name}: ${e.message}`)
    if (authorizationGroupId) {
      if (Array.isArray(authorizationGroupId))
        console.warn(`getAuthorizationGroups(<TOKEN>,${authorizationGroupId}) failed and returned null.`)
      else
        console.warn(`getAuthorizationGroup(<TOKEN>,${authorizationGroupId},${options}) failed and returned null.`)
    }
    else {
      console.warn(`listAuthorizationGroups(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
    }
    return authorizationGroupId ? (Array.isArray(authorizationGroupId) ? {} : null) : []
  }
}

function prepareAuthorizationGroupCreation({
  code,
  description = '',
  userIds = [],
} = {}) {
  const creation = {
    code,
    description,
    userIds,
  }
  return creation
}

async function createAuthorizationGroup({ creation }) {
  try {
    const openBisStore = useOpenBisStore()
    const result = await openBisStore.v3.createAuthorizationGroups([creation])
    return result[0]
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`createAuthorizationGroup(<TOKEN>,${creation}) failed and returned null.`)
    return null
  }
}

async function createAuthorizationGroups({ creations }) {
  try {
    const openBisStore = useOpenBisStore()
    return await openBisStore.v3.createAuthorizationGroups(creations)
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`createAuthorizationGroups(<TOKEN>,${creations}) failed and returned null.`)
    return null
  }
}

async function updateAuthorizationGroup({ authorizationGroupId, description, users }) {
  const update = new openbis.AuthorizationGroupUpdate()
  update.setAuthorizationGroupId(authorizationGroupId)

  if (description)
    update.setDescription(description)

  if (users) {
    const action = new openbis.ListUpdateValue.ListUpdateAction()
    action.setItems(users)
    update.setUserIdActions([action])
  }

  try {
    const openBisStore = useOpenBisStore()
    await openBisStore.v3.updateAuthorizationGroups([update])
    return true
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`updateAuthorizationGroup(<TOKEN>,${update}) failed and returned null.`)
    return false
  }
}

async function deleteAuthorizationGroup({ authorizationGroupId, reason }) {
  try {
    const openBisStore = useOpenBisStore()
    const options = new openbis.AuthorizationGroupDeletionOptions().setReason(reason)
    await openBisStore.v3.deleteAuthorizationGroups([authorizationGroupId], options)
    return true
  }
  catch (error) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`deleteAuthorizationGroup(<TOKEN>,${authorizationGroupId},${reason}) failed and returned false.`)
    return false
  }
}

export {
  listPersons,
  listPersonsWithCriteria,
  listPersonsOfSpace,
  listPersonsOfProject,
  listPersonsOfProjectById,
  getPerson,
  preparePersonCreation,
  createPerson,
  isPersonAdmin,
  listRoleAssignments,
  getRoleAssignment,
  getRoleAssignments,
  prepareRoleAssignmentCreation,
  createRoleAssignment,
  createRoleAssignments,
  deleteRoleAssignment,
  getAuthorizationGroups,
  prepareAuthorizationGroupCreation,
  createAuthorizationGroup,
  createAuthorizationGroups,
  updateAuthorizationGroup,
  deleteAuthorizationGroup
}

