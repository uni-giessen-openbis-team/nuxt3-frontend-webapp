import { defineStore } from 'pinia'
import openbis from 'http://localhost:3000/openbis/resources/api/v3/openbis.esm.js'
import type { Space } from './openbisTypes'

export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    v3: (() => {
      const v3Instance = new openbis.openbis()
      v3Instance.login('admin', 'whatever_value') // Assuming credentials are static
      return v3Instance
    })(),
    spaces: [] as Space[] | null,
  }),
  actions: {
    async loadV3API() {
      this.v3 = new openbis.openbis()
      try {
        await this.v3.login('admin', 'whatever_value') // Replace with actual credentials
        console.log('Logged in to openbis API')
      }
      catch (error) {
        console.error('Error logging in to openbis API:', error)
        this.v3 = null
      }
    },

    async fetchSpaces() {
      if (!this.v3) {
        console.error('v3 API is not initialized. Please call loadV3API first.')
        return
      }

      try {
        const searchCriteria = new openbis.SpaceSearchCriteria()
        const fetchOptions = new openbis.SpaceFetchOptions()
        const result = await this.v3.searchSpaces(searchCriteria, fetchOptions)
        this.spaces = result.getObjects()
      }
      catch (error) {
        console.error('Error fetching spaces:', error)
      }
    },

    async logout() {
      if (!this.v3) {
        console.error('v3 API is not initialized. Please call loadV3API first.')
        return
      }

      try {
        await this.v3.logout()
        console.log('Logged out of openbis API')
      }
      catch (error) {
        console.error('Error logging out of openbis API:', error)
      }
    },

    //   /* ----- Person API Methods ---------------------------------------------------------------- */

    //   listPersons({ criteria, options }) {
    //     try {
    //       const persons = this.v3.searchPersons(criteria, options)
    //       return persons.objects
    //     }
    //     catch (error) {
    //       console.error(`${error.constructor.name}: ${error.message}`)
    //       console.warn(`listPersons(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
    //       return []
    //     }
    //   },

    //   listPersonsWithCriteria({ criteria }) {
    //     return this.listPersons({ criteria, options: this.fetchPersonCompletely() })
    //   },

    //   listPersonsWithToken() {
    //     const { PersonSearchCriteria } = this.loadedResources
    //     return this.listPersons({ criteria: new PersonSearchCriteria(), options: this.fetchPersonCompletely() })
    //   },

    //   async listPersonsOfSpace(spaceCode: string): searchResult {
    //     const { RoleAssignmentSearchCriteria, SpacePermId } = this.loadedResources
    //     try {
    //       const criteria = new RoleAssignmentSearchCriteria()
    //       criteria.withSpace().withCode().thatEquals(spaceCode)
    //       const roleAssignments = await this.v3.searchRoleAssignments(criteria, this.fetchRoleAssignmentWithSpaceAndUser())
    //       const listOfPers = roleAssignments.objects.map(roleAssignment => roleAssignment.user)
    //       console.log('🚀 ~ file: openbisAPI.ts:297 ~ listPersonsOfSpace ~ listOfPers:', listOfPers)
    //       return listOfPers
    //     }
    //     catch (error) {
    //       console.error(`${error.constructor.name}: ${error.message}`)
    //       console.warn(`listPersonsOfSpace(${spaceCode}) failed and returned an empty list.`)
    //       return []
    //     }
    //   },

    //   async listPersonsOfProject({ project }) {
    //     const { RoleAssignmentSearchCriteria } = this.loadedResources
    //     const criteria = new RoleAssignmentSearchCriteria().withOrOperator()
    //     criteria.withProject().withId().thatEquals(project.getIdentifier())
    //     criteria.withSpace().withId().thatEquals(project.getSpace().getPermId())
    //     const results = await this.v3.searchRoleAssignments(
    //       criteria,
    //       this.fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
    //     )

    //     const projectMembers = new Set() // No duplicates
    //     results.getObjects().forEach((ra) => {
    //       if (Role.OBSERVER.equals(ra.getRole()) || (RoleLevel.INSTANCE.equals(ra.getRoleLevel()) && Role.ADMIN.equals(ra.getRole())))
    //         return

    //       if (ra.getUser() != null)
    //         projectMembers.add(ra.getUser())
    //       else
    //         projectMembers.addAll(ra.getAuthorizationGroup().getUsers())
    //     })

    //     return Array.from(projectMembers)
    //   },

    //   async listPersonsOfProjectById({ projectId }) {
    //     const project = await this.getProject(projectId)
    //     return this.listPersonsOfProject(project)
    //   },

    //   async getPerson({ userId, options = this.fetchPersonCompletely() }) {
    //     const result = await this.v3.getPersons(
    //       [userId],
    //       options,
    //     )
    //     return result.get(userId)
    //   },

    //   preparePersonCreation({ userId, spaceId }): creationType {
    //     const { PersonCreation } = this.loadedResources
    //     const creation = new PersonCreation()
    //     creation.setUserId(userId)
    //     if (spaceId)
    //       creation.setSpaceId(spaceId)
    //     return creation
    //   },

    //   async createPerson(creation: creationType) {
    //     const result = await this.v3.createPersons([creation])
    //     return result[0]
    //   },

    //   async isPersonAdmin({ personId, userId, person, spaceId, projectId }) {
    //     if (personId || userId) {
    //       const { PersonPermId, PersonSearchCriteria, Role, RoleLevel } = this.loadedResources

    //       personId = personId || new PersonPermId(userId)
    //       const criteria = new PersonSearchCriteria()
    //       criteria.withId().thatEquals(personId)

    //       const persons = await this.v3.searchPersons(
    //         criteria,
    //         this.fetchPersonCompletely(),
    //       )

    //       if (persons.getTotalCount() < 1)
    //         throw new Error(`Could not find person with user id: ${personId}`)

    //       for (const role of persons.getObjects()[0].getRoleAssignments()) {
    //         if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
    //           return true
    //       }
    //     }

    //     if (person) {
    //       try {
    //         const { Role, RoleLevel } = this.loadedResources

    //         for (const role of person.getRoleAssignments()) {
    //           if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
    //             return true
    //         }
    //       }
    //       catch (error) {
    //         return this.isPersonAdmin({ personId: person.getPermId() })
    //       }
    //     }

    //     if (spaceId || projectId) {
    //       if (await this.isPersonAdmin({ personId }))
    //         return true

    //       const { RoleAssignmentSearchCriteria, Role, RoleLevel } = this.loadedResources
    //       const criteria = new RoleAssignmentSearchCriteria()
    //       criteria.withSpace().withId().thatEquals(spaceId)
    //       criteria.withProject().withId().thatEquals(projectId)

    //       const result = await this.v3.searchRoleAssignments(
    //         criteria,
    //         this.fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
    //       )

    //       for (const roleAssignment of result.getObjects()) {
    //         if (roleAssignment.getRole() === Role.ADMIN && roleAssignment.getRoleLevel() === RoleLevel.SPACE) {
    //           if (roleAssignment.getUser() && roleAssignment.getUser().getPermId().equals(personId))
    //             return true

    //           if (roleAssignment.getAuthorizationGroup() && roleAssignment.getAuthorizationGroup().getUsers().map(user => user.getPermId()).includes(personId))
    //             return true
    //         }
    //       }
    //     }

    //     return false
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- AuthorizationGroup API Methods ---------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */

    //   async getAuthorizationGroups({

    //     criteria = new AuthorizationGroupSearchCriteria(),
    //     options = this.fetchAuthorizationGroupCompletely(),
    //     authorizationGroupId,
    //   } = {}) {
    //     try {
    //       if (authorizationGroupId) {
    //         let result
    //         if (Array.isArray(authorizationGroupId)) {
    //           result = await this.v3.getAuthorizationGroups(

    //             authorizationGroupId,
    //             options,
    //           )
    //         }
    //         else {
    //           result = await this.v3.getAuthorizationGroups(

    //             [authorizationGroupId],
    //             options,
    //           )
    //           result = result.get(authorizationGroupId)
    //         }

    //         return result
    //       }
    //       else {
    //         const result = await this.v3.searchAuthorizationGroups(criteria, options)
    //         return result.getObjects()
    //       }
    //     }
    //     catch (e) {
    //       console.error(`${e.constructor.name}: ${e.message}`)
    //       if (authorizationGroupId) {
    //         if (Array.isArray(authorizationGroupId))
    //           console.warn(`getAuthorizationGroups(<TOKEN>,${authorizationGroupId}) failed and returned null.`)

    //         else
    //           console.warn(`getAuthorizationGroup(<TOKEN>,${authorizationGroupId},${options}) failed and returned null.`)
    //       }
    //       else {
    //         console.warn(`listAuthorizationGroups(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
    //       }
    //       return authorizationGroupId ? (Array.isArray(authorizationGroupId) ? {} : null) : []
    //     }
    //   },

    //   // Call prepareAuthorizationGroupCreation:
    //   // let group1 = prepareAuthorizationGroupCreation({ code: 'myCode', description: 'myDescription', userIds: ['id1', 'id2'] });
    //   // let group2 = prepareAuthorizationGroupCreation({ code: 'myCode2', description: 'myDescription2' });
    //   // let group3 = prepareAuthorizationGroupCreation({ code: 'myCode3' });

    //   prepareAuthorizationGroupCreation({
    //     code,
    //     description = '',
    //     userIds = [],
    //   } = {}) {
    //     const creation = {
    //       code,
    //       description,
    //       userIds,
    //     }

    //     return creation
    //   },

    //   async createAuthorizationGroup({ creation }) {
    //     try {
    //       const result = await this.v3.createAuthorizationGroups([creation])
    //       return result[0]
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`createAuthorizationGroup(<TOKEN>,${creation}) failed and returned null.`)
    //       return null
    //     }
    //   },

    //   async createAuthorizationGroups({ creations }) {
    //     try {
    //       return await this.v3.createAuthorizationGroups(creations)
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`createAuthorizationGroups(<TOKEN>,${creations}) failed and returned null.`)
    //       return null
    //     }
    //   },

    //   async updateAuthorizationGroup({ authorizationGroupId, description, users }) {
    //     const update = new AuthorizationGroupUpdate()
    //     update.setAuthorizationGroupId(authorizationGroupId)

    //     if (description)
    //       update.setDescription(description)

    //     if (users) {
    //       const action = new ListUpdateValue.ListUpdateAction()
    //       action.setItems(users)
    //       update.setUserIdActions([action])
    //     }

    //     try {
    //       await this.v3.updateAuthorizationGroups([update])
    //       return true
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`updateAuthorizationGroup(<TOKEN>,${update}) failed and returned null.`)
    //       return false
    //     }
    //   },

    //   async deleteAuthorizationGroup({ authorizationGroupId, reason }) {
    //     try {
    //       const options = new AuthorizationGroupDeletionOptions().setReason(reason)
    //       await this.v3.deleteAuthorizationGroups([authorizationGroupId], options)
    //       return true
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`deleteAuthorizationGroup(<TOKEN>,${authorizationGroupId},${reason}) failed and returned false.`)
    //       return false
    //     }
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- RoleAssignment API Methods -------------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */

    //   async listRoleAssignments({ criteria, options }) {
    //     try {
    //       const result = await this.v3.searchRoleAssignments(criteria, options)
    //       return result.getObjects()
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`listRoleAssignments(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
    //       return []
    //     }
    //   },
    //   async getRoleAssignment({ roleAssignmentId, options }) {
    //     try {
    //       const result = await this.v3.getRoleAssignments([roleAssignmentId], options)
    //       return result.get(roleAssignmentId)
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`getRoleAssignment(<TOKEN>,${roleAssignmentId},${options}) failed and returned null.`)
    //       return null
    //     }
    //   },

    //   async getRoleAssignments({ roleAssignmentIds }) {
    //     try {
    //       return await this.v3.getRoleAssignments(roleAssignmentIds, this.fetchRoleAssignmentCompletely())
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`getRoleAssignments(<TOKEN>,${roleAssignmentIds}) failed and returned null.`)
    //       return null
    //     }
    //   },

    //   prepareRoleAssignmentCreation({ role, spaceId, projectId, userId, authorizationGroupId }) {
    //     const creation = new RoleAssignmentCreation()
    //     creation.setRole(role)
    //     creation.setSpaceId(spaceId || null)
    //     creation.setProjectId(projectId || null)
    //     creation.setUserId(userId || null)
    //     creation.setAuthorizationGroupId(authorizationGroupId || null)
    //     return creation
    //   },

    //   async createRoleAssignment({ creation }) {
    //     try {
    //       return (await this.v3.createRoleAssignments([creation]))[0]
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`createRoleAssignment(<TOKEN>,${creation}) failed and returned null.`)
    //       return null
    //     }
    //   },

    //   async createRoleAssignments({ creations }) {
    //     try {
    //       return await this.v3.createRoleAssignments(creations)
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`createRoleAssignments(<TOKEN>,${creations}) failed and returned null.`)
    //       return null
    //     }
    //   },

    //   async deleteRoleAssignment({ roleAssignmentId, reason }) {
    //     try {
    //       const options = new RoleAssignmentDeletionOptions().setReason(reason)
    //       await this.v3.deleteRoleAssignments([roleAssignmentId], options)
    //       return true
    //     }
    //     catch (error) {
    //       console.error(`${error.name}: ${error.message}`)
    //       console.warn(`deleteRoleAssignment(<TOKEN>,${roleAssignmentId},${reason}) failed and returned false.`)
    //       return false
    //     }
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- Space API Methods ----------------------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */
    //   listSpaces(criteria = {}, options = {}) {
    //     const { SpaceSearchCriteria, SpaceFetchOptions } = this.loadedResources
    //     const spaceCodes = []

    //     const spaces = this.v3.searchSpaces(new SpaceSearchCriteria(criteria), new SpaceFetchOptions(options))

    //     if (spaces.totalCount === 0)
    //       return spaceCodes

    //     return spaces.objects.map(space => space.code)
    //   },

    //   getSpace(spaceId, options = {}) {
    //     const { SpaceFetchOptions, SpacePermId } = this.loadedResources

    //     const result = this.v3.getSpaces([new SpacePermId(spaceId)], new SpaceFetchOptions(options))

    //     return result.get(spaceId)
    //   },

    //   prepareSpaceCreation(spaceCode, description = null) {
    //     const { SpaceCreation } = this.loadedResources
    //     const creation = new SpaceCreation()
    //     creation.setCode(spaceCode)

    //     if (description)
    //       creation.setDescription(description)

    //     return creation
    //   },

    //   createSpace(spaceCode, description = null) {
    //     return this.v3.createSpaces([this.prepareSpaceCreation(spaceCode, description)])[0]
    //   },

    //   createSpaces(spaces) {
    //     return this.v3.createSpaces(spaces)
    //   },

    //   updateSpace(space) {
    //     this.v3.updateSpaces([space])

    //     return true
    //   },

    //   deleteSpace(spaceId, reason) {
    //     const { SpaceDeletionOptions, SpacePermId } = this.loadedResources
    //     const sdo = new SpaceDeletionOptions().setReason(reason)

    //     this.v3.deleteSpaces([new SpacePermId(spaceId)], sdo)

    //     return true
    //   },
    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- Project API Methods --------------------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */

    //   listProjects(criteria = {}, options = {}) {
    //     const { ProjectSearchCriteria, ProjectFetchOptions } = this.loadedResources

    //     const projects = this.v3.searchProjects(new ProjectSearchCriteria(criteria), new ProjectFetchOptions(options))

    //     return projects.objects
    //   },

    //   listProjectsOfSpace(spaceCode) {
    //     const { ProjectSearchCriteria, ProjectFetchOptions } = this.loadedResources

    //     const psc = new ProjectSearchCriteria()
    //     psc.withSpace().withCode().thatEquals(spaceCode)

    //     const result = this.v3.searchProjects(psc, new ProjectFetchOptions())

    //     return result.objects
    //   },

    //   getProject(projectId, options = {}) {
    //     const { ProjectFetchOptions, ProjectPermId } = this.loadedResources

    //     const result = this.v3.getProjects([new ProjectPermId(projectId)], new ProjectFetchOptions(options))

    //     return result.get(projectId)
    //   },

    //   // createProject( projectCode, spaceCode, description = null) {
    //   //   return this.v3.createProjects( [this.prepareProjectCreation(projectCode, spaceCode, description)])[0]
    //   // },
    //   createProjects(projects) {
    //     return this.v3.createProjects(projects)
    //   },

    //   updateProject(project) {
    //     this.v3.updateProjects([project])

    //     return true
    //   },

    //   updateProjects(projects) {
    //     this.v3.updateProjects(projects)

    //     return true
    //   },

    //   deleteProject(projectId, reason) {
    //     const { ProjectDeletionOptions } = this.loadedResources
    //     const pdo = new ProjectDeletionOptions().setReason(reason)

    //     this.v3.deleteProjects([projectId], pdo)

    //     return true
    //   },
    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- Collection API Methods ------------------------------------------------------------ */
    //   /* ----------------------------------------------------------------------------------------- */

    //   listCollections(criteria = new ExperimentSearchCriteria(), options = this.fetchCollectionCompletely()) {
    //     const result = v3.searchExperiments(criteria, options)
    //     return result.getObjects()
    //   },

    //   listCollectionsOfType(typeId) {
    //     const criteria = new ExperimentSearchCriteria().withType().withId().thatEquals(typeId)
    //     return this.listCollections(criteria)
    //   },

    //   listCollectionsOfSpace(spaceCode) {
    //     const criteria = new ExperimentSearchCriteria().withProject().withSpace().withCode().thatEquals(spaceCode)
    //     return this.listCollections(criteria)
    //   },

    //   listCollectionsOfProject(projectId) {
    //     const criteria = new ExperimentSearchCriteria().withProject().withId().thatEquals(projectId)
    //     return this.listCollections(criteria)
    //   },

    //   getCollection(collectionId, options = this.fetchPropertyTypeWithVocabularyAndTerms.fetchCollectionCompletely()) {
    //     const result = v3.getExperiments([collectionId], options)
    //     return result.get(collectionId)
    //   },

    //   getCollections(collectionIds) {
    //     return v3.getExperiments(collectionIds, this.fetchCollectionCompletely())
    //   },

    //   prepareCollectionCreation(collectionCode, typeId, projectId, properties = null) {
    //     const creation = new ExperimentCreation()
    //     creation.setCode(collectionCode)
    //     creation.setTypeId(typeId)
    //     creation.setProjectId(projectId)
    //     if (properties)
    //       creation.setProperties(properties)

    //     return creation
    //   },

    //   createCollection(collection) {
    //     return v3.createExperiments([collection]).get(0)
    //   },

    //   updateCollection(collection) {
    //     const update = new ExperimentUpdate()
    //     update.setExperimentId(collection.getIdentifier())
    //     update.setProjectId(collection.getProject().getIdentifier())
    //     update.setProperties(collection.getProperties())
    //     v3.updateExperiments([update])
    //     return true
    //   },

    //   deleteCollection(collectionId, reason) {
    //     const options = new ExperimentDeletionOptions().setReason(reason)
    //     return v3.deleteExperiments([collectionId], options)
    //   },

    //   deleteCollections(collections, reason) {
    //     const collectionIds = collections.map(collection => collection.getIdentifier())
    //     const options = new ExperimentDeletionOptions().setReason(reason)
    //     return v3.deleteExperiments(collectionIds, options)
    //   },

    //   deleteCollectionPermanently(collectionId, reason) {
    //     const deletionId = this.deleteCollection(collectionId, reason)
    //     v3.confirmDeletions([deletionId])
    //     return true
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- Object API Methods ---------------------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */
    //   listObjects(criteria, options) {
    //     const result = this.v3.searchSamples(criteria, options)
    //     return result.getObjects()
    //   },

    //   listObjectsOfType(typeId) {
    //     const criteria = new SampleSearchCriteria()
    //     criteria.withType().withId().thatEquals(typeId)
    //     return this.listObjects(criteria)
    //   },

    //   listObjectsOfSpace(spaceCode) {
    //     const criteria = new SampleSearchCriteria()
    //     criteria.withSpace().withCode().thatEquals(spaceCode)
    //     return this.listObjects(criteria)
    //   },

    //   listObjectsOfProject(projectId) {
    //     const criteria = new SampleSearchCriteria()
    //     criteria.withProject().withId().thatEquals(projectId)
    //     return this.listObjects(criteria)
    //   },

    //   listObjectsOfCollection(collectionId) {
    //     const criteria = new SampleSearchCriteria()
    //     criteria.withExperiment().withId().thatEquals(collectionId)
    //     return this.listObjects(criteria)
    //   },

    //   getObject(objectId, options) {
    //     const result = this.v3.getSamples([objectId], options)
    //     return result.get(objectId)
    //   },

    //   createObject(object) {
    //     return this.v3.createSamples([object])[0]
    //   },

    //   updateObject(object) {
    //     this.v3.updateSamples([object])
    //     return true
    //   },

    //   updateObjectParents(objectId, parentIds) {
    //     const update = new SampleUpdate()
    //     update.setSampleId(objectId)
    //     update.getParentIds().set(parentIds)
    //     this.updateObject(update)
    //     return true
    //   },

    //   updateObjectChildren(objectId, childrenIds) {
    //     const update = new SampleUpdate()
    //     update.setSampleId(objectId)
    //     update.getChildIds().set(childrenIds)
    //     this.updateObject(update)
    //     return true
    //   },

    //   deleteObjects(objects, reason, permanently = false) {
    //     const objectIds = Array.isArray(objects) ? objects.map(obj => obj.getIdentifier()) : [objects.getIdentifier()]
    //     const pdo = new SampleDeletionOptions().setReason(reason)
    //     const deletionId = this.v3.deleteSamples(objectIds, pdo)
    //     if (permanently)
    //       this.v3.confirmDeletions([deletionId])

    //     return deletionId
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- DataSetFile API Methods ----------------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */
    //   listDataSets(criteria?: DataSetSearchCriteria | DataSetFetchOptions, options?: DataSetFetchOptions): DataSet[] {
    //     const { DataSetSearchCriteria } = this.loadedResources

    //     if (Array.isArray(criteria)) {
    //       options = options || this.fetchDataSetCompletely()
    //     }
    //     else {
    //       options = criteria || this.fetchDataSetCompletely()
    //       criteria = new DataSetSearchCriteria()
    //     }

    //     const result = this.v3.searchDataSets(criteria, options)
    //     return result.getObjects()
    //   },

    //   deleteDataSet(datasetIds: IDataSetId | IDataSetId[], reason: string, permanently = false): IDeletionId | null {
    //     const { DataSetDeletionOptions } = this.loadedResources

    //     const ids = Array.isArray(datasetIds) ? datasetIds : [datasetIds]
    //     const ddo = new DataSetDeletionOptions().setReason(reason)
    //     const deletionId = this.v3.deleteDataSets(ids, ddo)

    //     if (permanently)
    //       this.v3.confirmDeletions([deletionId])

    //     return deletionId
    //   },

    //   listDataSetFiles(datasetId: IDataSetId | string | string[]): DataSetFile[] {
    //     const { DataSetFileSearchCriteria, DataSetFileFetchOptions } = this.loadedResources

    //     if (Array.isArray(datasetId)) {
    //       const datasetCodes = datasetId
    //       const criteria = new DataSetFileSearchCriteria().withDataSet().withCodes().thatIn(datasetCodes)
    //       const result = this.dss3.searchFiles(criteria, new DataSetFileFetchOptions())
    //       return result.getObjects()
    //     }
    //     else {
    //       const { DataSetPermId } = this.loadedResources
    //       const id = typeof datasetId === 'string' ? new DataSetPermId(datasetId) : datasetId
    //       const criteria = new DataSetFileSearchCriteria().withDataSet().withId().thatEquals(id)
    //       const result = this.dss3.searchFiles(criteria, new DataSetFileFetchOptions())
    //       return result.getObjects()
    //     }
    //   },

    //   getDataSetFileStream(datasetFileId: IDataSetFileId | DataSetFile): InputStream | null {
    //     const { DataSetFileDownloadOptions, DataSetFileDownloadReader } = this.loadedResources

    //     const id = datasetFileId instanceof DataSetFile ? datasetFileId.getPermId() : datasetFileId
    //     const options = new DataSetFileDownloadOptions().setRecursive(false)
    //     const stream = this.dss3.downloadFiles([id], options)
    //     const reader = new DataSetFileDownloadReader(stream)
    //     let file: DataSetFileDownload | null
    //     while ((file = reader.read()) !== null) {
    //       if (file.getDataSetFile().getId().equals(id))
    //         return file.getInputStream()
    //     }

    //     return null
    //   },

    //   getDataSetFileStreamByFileName(datasetId: IDataSetId, fileName: string): InputStream | null {
    //     const { DataSetFilePermId, DataSetFileDownloadOptions, DataSetFileDownloadReader } = this.loadedResources

    //     const datasetFileId = new DataSetFilePermId(datasetId)
    //     const options = new DataSetFileDownloadOptions().setRecursive(true)
    //     const stream = this.dss3.downloadFiles([datasetFileId], options)
    //     const reader = new DataSetFileDownloadReader(stream)
    //     let file: DataSetFileDownload | null
    //     while ((file = reader.read()) !== null) {
    //       if (file.getDataSetFile().getPath().endsWith(fileName))
    //         return file.getInputStream()
    //     }

    //     return null
    //   },

    //   getDataSetFilesStream(datasetFileIds: IDataSetFileId[]): InputStream | null {
    //     const { DataSetFileDownloadOptions } = this.loadedResources

    //     const options = new DataSetFileDownloadOptions().setRecursive(false)
    //     return this.dss3.downloadFiles(datasetFileIds, options)
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- Vocabulary API Methods ------------------------------------------------------------ */
    //   /* ----------------------------------------------------------------------------------------- */

    //   listVocabularies(criteria?: VocabularySearchCriteria, options?: VocabularyFetchOptions): Vocabulary[] {
    //     const { VocabularyFetchOptions } = this.loadedResources

    //     const result = this.v3.searchVocabularies(criteria, options)
    //     return result.getObjects()
    //   },

    //   listAllVocabularies(): Vocabulary[] {
    //     const { VocabularySearchCriteria } = this.loadedResources

    //     return this.listVocabularies(new VocabularySearchCriteria(), this.fetchVocabularyCompletely())
    //   },

    //   getVocabulary(vocabularyId: IVocabularyId, options?: VocabularyFetchOptions): Vocabulary {
    //     const { VocabularyFetchOptions } = this.loadedResources

    //     const result = this.v3.getVocabularies([vocabularyId], options)
    //     return result.get(vocabularyId)
    //   },

    //   getVocabularyById(vocabularyId: IVocabularyId): Vocabulary {
    //     const { VocabularyFetchOptions } = this.loadedResources

    //     return this.getVocabulary(vocabularyId, this.fetchVocabularyCompletely())
    //   },

    //   getVocabularyByCode(vocabularyCode: string): Vocabulary {
    //     const { VocabularyPermId, VocabularyFetchOptions } = this.loadedResources

    //     return this.getVocabulary(new VocabularyPermId(vocabularyCode), this.fetchVocabularyCompletely())
    //   },

    //   getVocabulariesByCodes(vocabularyCodes: string[]): Map<IVocabularyId, Vocabulary> {
    //     const { VocabularyPermId, VocabularyFetchOptions } = this.loadedResources

    //     const vocabularyIds = vocabularyCodes.map(code => new VocabularyPermId(code))
    //     return this.v3.getVocabularies(vocabularyIds, this.fetchVocabularyCompletely())
    //   },

    //   /* ----------------------------------------------------------------------------------------- */
    //   /* ----- VocabularyTerm API Methods -------------------------------------------------------- */
    //   /* ----------------------------------------------------------------------------------------- */

    //   listVocabularyTerms(criteria?: VocabularyTermSearchCriteria, options?: VocabularyTermFetchOptions): VocabularyTerm[] {
    //     const { VocabularyTermSearchCriteria } = this.loadedResources

    //     const result = this.v3.searchVocabularyTerms(criteria, options)
    //     return result.getObjects()
    //   },

    //   listAllVocabularyTerms(): VocabularyTerm[] {
    //     const { VocabularyTermSearchCriteria } = this.loadedResources

    //     return this.listVocabularyTerms(new VocabularyTermSearchCriteria(), this.fetchVocabularyTermCompletely())
    //   },

    //   listVocabularyTermsByVocabularyId(vocabularyId: IVocabularyId): VocabularyTerm[] {
    //     const { VocabularyTermSearchCriteria } = this.loadedResources

    //     const criteria = new VocabularyTermSearchCriteria().withVocabulary().withId().thatEquals(vocabularyId)
    //     return this.listVocabularyTerms(criteria)
    //   },

    //   listVocabularyTermsByVocabularyCode(vocabularyCode: string): VocabularyTerm[] {
    //     const { VocabularyTermSearchCriteria } = this.loadedResources

    //     const criteria = new VocabularyTermSearchCriteria().withVocabulary().withCode().thatEquals(vocabularyCode)
    //     return this.listVocabularyTerms(criteria)
    //   },

    //   listVocabularyTermsByProperty(property: PropertyType): VocabularyTerm[] {
    //     try {
    //       const fullProperty = this.v3.getPropertyTypes(
    //         List.of(property.getPermId()),
    //         this.fetchPropertyTypeWithVocabularyAndTerms(),
    //       ).get(property.getPermId())

    //       if (fullProperty === null)
    //         throw new IllegalArgumentException(`PropertyType ${property.getCode()} does not exist.`)

    //       return fullProperty.getVocabulary().getTerms()
    //     }
    //     catch (error) {
    //       logger.error(`${error.constructor.name}: ${error.message}`)
    //       logger.warn(`listVocabularyTerms(<TOKEN>,${property}) failed and returned an empty list.`)
    //       return []
    //     }
    //   },

    //   getVocabularyTerm(vocabularyTermId: IVocabularyTermId, options?: VocabularyTermFetchOptions): VocabularyTerm {
    //     const { VocabularyTermFetchOptions } = this.loadedResources

    //     const result = this.v3.getVocabularyTerms([vocabularyTermId], options)
    //     return result.get(vocabularyTermId)
    //   },

    //   getVocabularyTermById(vocabularyTermId: IVocabularyTermId): VocabularyTerm {
    //     const { VocabularyTermFetchOptions } = this.loadedResources

    //     return this.getVocabularyTerm(vocabularyTermId, this.fetchVocabularyTermCompletely())
    //   },

    //   getVocabularyTermByCode(vocabularyTermCode: string, vocabularyCode: string): VocabularyTerm {
    //     const { VocabularyTermPermId, VocabularyTermFetchOptions } = this.loadedResources

    //     return this.getVocabularyTerm(
    //       new VocabularyTermPermId(vocabularyTermCode, vocabularyCode),
    //       this.fetchVocabularyTermCompletely(),
    //     )
    //   },

    //   getVocabularyTermsByCodes(vocabularyTermIds: Map<string, string>): Map<IVocabularyTermId, VocabularyTerm> {
    //     const { VocabularyTermPermId, VocabularyTermFetchOptions } = this.loadedResources

    //     const vocabularyTermIdList = Array.from(vocabularyTermIds, ([key, value]) => new VocabularyTermPermId(key, value))
    //     return this.getVocabularyTerms(vocabularyTermIdList)
    //   },

    //   createVocabularyTerm(creation: VocabularyTermCreation): IVocabularyTermId {
    //     const { VocabularyTermCreation } = this.loadedResources
    //     return this.v3.createVocabularyTerms([creation])[0]
    //   },

    //   // answer from email. How create VocabTerms

    //   // var creation = new VocabularyTermCreation();
    //   // creation.setVocabularyId(new VocabularyPermId("MY_VOCABULARY_CODE"));
    //   // creation.setCode("MY_TERM_CODE");
    //   // creation.setLabel("My term label");
    //   // creation.setDescription("My term description");

    //   // v3.createVocabularyTerms([ creation ]).done(function(result) {
    //   //     alert("Created term: " + result[0]);
    //   // }).fail(function(error){
    //   //     alert("Something went wrong: " + JSON.stringify(error))
    //   // });

    //   createVocabularyTermByVocabulary(vocabularyId: IVocabularyId, code: string, label?: string, description?: string): IVocabularyTermId {
    //     const { VocabularyTermCreation } = this.loadedResources

    //     const creation = new VocabularyTermCreation()
    //     creation.setVocabularyId(vocabularyId)
    //     creation.setCode(code)
    //     creation.setLabel(label)
    //     creation.setDescription(description)

    //     return this.createVocabularyTerm(creation)
    //   },

    //   updateVocabularyTerm(update: VocabularyTermUpdate): boolean {
    //     const { VocabularyTermUpdate } = this.loadedResources

    //     try {
    //       this.v3.updateVocabularyTerms([update])
    //       return true
    //     }
    //     catch (error) {
    //       logger.error(`${error.constructor.name}: ${error.message}`)
    //       logger.warn(`updateVocabularyTerm(<TOKEN>,${update}) failed and returned null.`)
    //       return false
    //     }
    //   },

    //   updateVocabularyTermLabel(vocabularyTermId: IVocabularyTermId, label: string): boolean {
    //     const { VocabularyTermUpdate } = this.loadedResources

    //     const update = new VocabularyTermUpdate()
    //     update.setVocabularyTermId(vocabularyTermId)
    //     update.setLabel(label)

    //     return this.updateVocabularyTerm(update)
    //   },

    //   login(user, password) {
    //     return this.promise(this.v3.login(user, password))
    //       .then((sessionToken) => {
    //         this.sessionToken = sessionToken
    //         return sessionToken
    //       })
    //   },

    //   // Vocabulary code is something like "SPECIES"
    //   async getVocabularyTerms(vocabularyTermIds: IVocabularyTermId[]): Map<IVocabularyTermId, VocabularyTerm> {
    //     const { VocabularyTermPermId, VocabularyTermFetchOptions } = this.loadedResources
    //     const VocabularyTerms = await this.v3.getVocabularyTerms(vocabularyTermIds, this.fetchVocabularyTermCompletely())
    //     return VocabularyTerms
    //   },

    //   // One space for each working group
    //   async getAllSpaces(): Promise<Space[]> {
    //     const { SpaceSearchCriteria, SpaceFetchOptions } = this.loadedResources
    //     const criteria = new SpaceSearchCriteria()
    //     const fo = new SpaceFetchOptions()
    //     return await this.searchSpaces(criteria, fo)
    //   },

    //   prepareProjectCreation(projectCode, spaceCode, description = null) {
    //     const { ProjectCreation, SpacePermId } = this.loadedResources

    //     const creation = new ProjectCreation()
    //     creation.setCode(projectCode)
    //     creation.setSpaceId(new SpacePermId(spaceCode))

    //     if (description)
    //       creation.setDescription(description)

    //     return creation
    //   },

    //   async createProject(projectCode, spaceCode, description) {
    //     const creation = await this.prepareProjectCreation(projectCode, spaceCode, description)
    //     return await this.v3.createProjects(creation)
    //   },

    //   // The main function
    //   // pass the sampleGroups in the right order. From top to bottom hiracy
    //   async createSamplesFromWizzard(projectContext, sampleGroups) {
    //     const { SampleCreation, EntityTypePermId, SpacePermId, CreationId } = this.loadedResources

    //     const createdSamples = []
    //     const sampleCreationsDict = {}

    //     for (const sampleList of sampleGroups) {
    //       for (const sample of sampleList) {
    //         const sampleCreation = new SampleCreation()
    //         sampleCreation.setTypeId(new EntityTypePermId(sample.sampleType))
    //         sampleCreation.setSpaceId(new SpacePermId(projectContext.space))
    //         sampleCreation.setCreationId(new CreationId(sample.secondaryName))

    //         // Iterate over conditions and set property for each
    //         for (const condition of sample.conditions) {
    //           for (const [key, value] of Object.entries(condition))
    //             sampleCreation.setProperty(key, value)
    //         }
    //         // sampleCreation.setCode('MY_SAMPLE_CODE')
    //         // sampleCreation.setExperimentId(new ExperimentIdentifier('/MY_SPACE_CODE/MY_PROJECT_CODE/MY_EXPERIMENT_CODE'))

    //         if (sample.parent) {
    //           // If the sample has a parent, directly get the parent's SampleCreation object from the dictionary
    //           const parentSampleCreation = sampleCreationsDict[sample.parent]
    //           if (parentSampleCreation) {
    //             sampleCreation.setParentIds([parentSampleCreation.getCreationId()])

    //             // Add the sample's creation ID to the parent's child IDs
    //             const parentChildIds = parentSampleCreation.getChildIds() || []
    //             parentChildIds.push(sampleCreation.getCreationId())
    //             parentSampleCreation.setChildIds(parentChildIds)
    //           }
    //           else { console.log('Parent sample not found') }
    //         }

    //         sample.sampleCreation = sampleCreation
    //         // Add the SampleCreation object to the dictionary
    //         sampleCreationsDict[sample.secondaryName] = sampleCreation
    //         createdSamples.push(sampleCreation)
    //       }
    //     }

    //     return await this.v3.createSamples([createdSamples[0]]).done((permIds) => {
    //       alert(`Perm ids: ${JSON.stringify(permIds)}`)
    //     })
    //     // return createdSamples
    //   },

    //   /// /////////////// FetchOptions ////////////////////////
    //   /// ///////////////// Person  ///////////////////////////
    //   fetchPersonCompletely() {
    //     const { PersonFetchOptions } = this.loadedResources
    //     const options = new PersonFetchOptions()
    //     options.withRegistrator()
    //     options.withSpace()
    //     options.withRoleAssignments()
    //     return options
    //   },

    //   fetchPersonWithSpace() {
    //     const { PersonFetchOptions } = this.loadedResources
    //     const options = new PersonFetchOptions()
    //     options.withSpaceUsing(this.fetchSpaceCompletely())
    //     return options
    //   },

    //   /// ///////////////// Role Assighnment /////////////
    //   fetchRoleAssignmentCompletely() {
    //     const { RoleAssignmentFetchOptions } = this.loadedResources
    //     const options = new RoleAssignmentFetchOptions()
    //     options.withRegistrator()
    //     options.withSpace()
    //     options.withProject()
    //     options.withUser()
    //     options.withAuthorizationGroup()
    //     return options
    //   },
    //   fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely() {
    //     const { RoleAssignmentFetchOptions } = this.loadedResources
    //     const options = new RoleAssignmentFetchOptions()
    //     options.withRegistrator()
    //     options.withSpace()
    //     options.withProject()
    //     options.withUserUsing(this.fetchPersonCompletely())
    //     options.withAuthorizationGroupUsing(this.fetchAuthorizationGroupWithUsers())
    //     return options
    //   },
    //   fetchRoleAssignmentWithSpaceAndUser() {
    //     const { RoleAssignmentFetchOptions } = this.loadedResources
    //     const options = new RoleAssignmentFetchOptions()
    //     options.withSpaceUsing(this.fetchSpaceCompletely())
    //     options.withUserUsing(this.fetchPersonCompletely())
    //     return options
    //   },

    //   fetchRoleAssignmentWithProjectAndUser() {
    //     const { RoleAssignmentFetchOptions } = this.loadedResources
    //     const options = new RoleAssignmentFetchOptions()
    //     options.withProjectUsing(this.fetchProjectCompletely())
    //     options.withUserUsing(this.fetchPersonCompletely())
    //     return options
    //   },
    //   /// ///////// Authorization group //////////////

    //   fetchAuthorizationGroupCompletely() {
    //     const { AuthorizationGroupFetchOptions } = this.loadedResources
    //     const options = new AuthorizationGroupFetchOptions()
    //     options.withRegistrator()
    //     options.withRoleAssignments()
    //     options.withUsers()
    //     return options
    //   },

    //   fetchAuthorizationGroupWithUsersCompletely() {
    //     const { AuthorizationGroupFetchOptions } = this.loadedResources
    //     const options = new AuthorizationGroupFetchOptions()
    //     options.withRegistrator()
    //     options.withRoleAssignments()
    //     options.withUsersUsing(this.fetchPersonCompletely())
    //     return options
    //   },

    //   fetchAuthorizationGroupWithUsers() {
    //     const { AuthorizationGroupFetchOptions } = this.loadedResources
    //     const options = new AuthorizationGroupFetchOptions()
    //     options.withUsersUsing(this.fetchPersonCompletely())
    //     return options
    //   },

    //   // Space
    //   fetchSpaceCompletely() {
    //     const { SpaceFetchOptions } = this.loadedResources
    //     const options = new SpaceFetchOptions()
    //     options.withRegistrator()
    //     options.withProjects()
    //     options.withSamples()
    //     return options
    //   },

    //   fetchSpaceWithProjectCompletely() {
    //     const { SpaceFetchOptions } = this.loadedResources
    //     const options = new SpaceFetchOptions()
    //     options.withRegistrator()
    //     options.withProjectsUsing(this.fetchProjectCompletely())
    //     options.withSamples()
    //     return options
    //   },

    //   /// //////////// Project ////////////////////////
    //   fetchProjectCompletely() {
    //     const { ProjectFetchOptions } = this.loadedResources
    //     const options = new ProjectFetchOptions()
    //     options.withRegistrator()
    //     options.withLeader()
    //     options.withSpace()
    //     options.withExperiments()
    //     options.withSamples()
    //     options.withAttachments()
    //     options.withHistory()
    //     options.withModifier()
    //     return options
    //   },

    //   fetchProjectWithCollections() {
    //     const { ProjectFetchOptions } = this.loadedResources
    //     const options = new ProjectFetchOptions()
    //     options.withRegistrator()
    //     options.withLeader()
    //     options.withSpace()
    //     options.withExperimentsUsing(this.fetchCollectionCompletely())
    //     options.withSamples()
    //     options.withAttachments()
    //     options.withHistory()
    //     options.withModifier()
    //     return options
    //   },
    //   /// ////////////// Collection ///////////
    //   fetchCollectionCompletely() {
    //     const { ExperimentFetchOptions } = this.loadedResources
    //     const options = new ExperimentFetchOptions()
    //     options.withRegistrator()
    //     options.withProject()
    //     options.withSamples()
    //     options.withDataSets()
    //     options.withAttachments()
    //     options.withHistory()
    //     options.withModifier()
    //     options.withMaterialProperties()
    //     options.withProperties()
    //     options.withTags()
    //     options.withType()
    //     return options
    //   },

    //   fetchCollectionWithProjectCompletely() {
    //     const { ExperimentFetchOptions } = this.loadedResources
    //     const options = new ExperimentFetchOptions()
    //     options.withRegistrator()
    //     options.withProjectUsing(this.fetchProjectCompletely())
    //     options.withSamples()
    //     options.withDataSets()
    //     options.withAttachments()
    //     options.withHistory()
    //     options.withModifier()
    //     options.withMaterialProperties()
    //     options.withProperties()
    //     options.withTags()
    //     options.withType()
    //     return options
    //   },

    //   fetchCollectionTypeCompletely() {
    //     const { ExperimentTypeFetchOptions } = this.loadedResources
    //     const options = new ExperimentTypeFetchOptions()
    //     options.withPropertyAssignments()
    //     options.withValidationPlugin()
    //     return options
    //   },

    //   /// ///////////// Sample ////////////////

    //   fetchObjectCompletely() {
    //     const { SampleFetchOptions } = this.loadedResources
    //     const options = new SampleFetchOptions()
    //     options.withRegistrator()
    //     options.withSpace()
    //     options.withProject()
    //     options.withExperiment()
    //     options.withDataSets()
    //     options.withAttachments()
    //     options.withComponents()
    //     options.withContainer()
    //     options.withHistory()
    //     options.withModifier()
    //     options.withMaterialProperties()
    //     options.withProperties()
    //     options.withTags()
    //     options.withType()
    //     options.withParents()
    //     options.withChildren()
    //     // options.withSampleProperties();  // ?
    //     return options
    //   },

    //   fetchObjectWithParentsAndChildrenCompletely() {
    //     const { SampleFetchOptions } = this.loadedResources
    //     const options = new SampleFetchOptions()
    //     options.withRegistrator()
    //     options.withSpace()
    //     options.withProject()
    //     options.withExperiment()
    //     options.withDataSets()
    //     options.withAttachments()
    //     options.withComponents()
    //     options.withContainer()
    //     options.withHistory()
    //     options.withModifier()
    //     options.withMaterialProperties()
    //     options.withProperties()
    //     options.withTags()
    //     options.withType()
    //     options.withParentsUsing(this.fetchObjectCompletely())
    //     options.withChildrenUsing(this.fetchObjectCompletely())
    //     // options.withSampleProperties();  // ?
    //     return options
    //   },

    //   fetchObjectWithParentsAndChildrenRecursive() {
    //     const { SampleFetchOptions } = this.loadedResources
    //     const options = new SampleFetchOptions()
    //     options.withRegistrator()
    //     options.withSpace()
    //     options.withProject()
    //     options.withExperiment()
    //     options.withDataSets()
    //     options.withAttachments()
    //     options.withComponents()
    //     options.withContainer()
    //     options.withHistory()
    //     options.withModifier()
    //     options.withMaterialProperties()
    //     options.withProperties()
    //     options.withTags()
    //     options.withType()
    //     options.withParentsUsing(options)
    //     options.withChildrenUsing(options)
    //     // options.withSampleProperties();  // ?
    //     return options
    //   },

    //   fetchObjectTypeCompletely() {
    //     const { SampleTypeFetchOptions } = this.loadedResources
    //     const options = new SampleTypeFetchOptions()
    //     options.withPropertyAssignments()
    //     options.withSemanticAnnotations()
    //     options.withValidationPlugin()
    //     return options
    //   },
    //   /* ----- DataSet / DataSetFile -------------------------------------------------------- */
    //   fetchDataSetCompletely() {
    //     const { DataSetFetchOptions } = this.loadedResources
    //     const options = new DataSetFetchOptions()
    //     options.withRegistrator()
    //     options.withExperiment()
    //     options.withSample()
    //     options.withDataStore()
    //     options.withComponents()
    //     options.withContainers()
    //     options.withHistory()
    //     options.withModifier()
    //     options.withMaterialProperties()
    //     options.withProperties()
    //     options.withTags()
    //     options.withType()
    //     options.withLinkedData()
    //     options.withParents()
    //     options.withChildren()
    //     options.withPhysicalData()
    //     return options
    //   },

    //   /* ----- Vocabulary / VocabularyTerm -------------------------------------------------- */
    //   fetchVocabularyCompletely() {
    //     const { VocabularyFetchOptions } = this.loadedResources
    //     const options = new VocabularyFetchOptions()
    //     options.withRegistrator()
    //     options.withTerms()
    //     return options
    //   },

    //   fetchVocabularyTermCompletely() {
    //     const { VocabularyTermFetchOptions } = this.loadedResources
    //     const options = new VocabularyTermFetchOptions()
    //     options.withRegistrator()
    //     options.withVocabulary()
    //     return options
    //   },

    //   /* ----- PropertyAssignment / PropertyType -------------------------------------------- */
    //   fetchPropertyTypeCompletely() {
    //     const { PropertyTypeFetchOptions } = this.loadedResources
    //     const options = new PropertyTypeFetchOptions()
    //     options.withRegistrator()
    //     options.withVocabulary()
    //     options.withSemanticAnnotations()
    //     options.withMaterialType()
    //     return options
    //   },

    //   fetchPropertyTypeWithVocabularyAndTerms() {
    //     const { PropertyTypeFetchOptions } = this.loadedResources
    //     const options = new PropertyTypeFetchOptions()
    //     options.withVocabularyUsing(this.fetchVocabularyCompletely())
    //     return options
    //   },

    //   fetchPropertyAssignmentCompletely() {
    //     const { PropertyAssignmentFetchOptions } = this.loadedResources
    //     const options = new PropertyAssignmentFetchOptions()
    //     options.withRegistrator()
    //     options.withPropertyType()
    //     options.withEntityType()
    //     options.withPlugin()
    //     return options
    //   },

    //   fetchPropertyAssignmentWithPropertyType() {
    //     const { PropertyAssignmentFetchOptions } = this.loadedResources
    //     const options = new PropertyAssignmentFetchOptions()
    //     options.withPropertyTypeUsing(this.fetchPropertyTypeCompletely())
    //     return options
    //   },

    //   /* ----- Material / MaterialType ------------------------------------------------------ */
    //   fetchMaterialCompletely() {
    //     const { MaterialFetchOptions } = this.loadedResources
    //     const options = new MaterialFetchOptions()
    //     options.withRegistrator()
    //     options.withHistory()
    //     options.withProperties()
    //     options.withMaterialProperties()
    //     options.withTags()
    //     options.withType()
    //     return options
    //   },

    //   fetchMaterialTypeCompletely() {
    //     const { MaterialTypeFetchOptions } = this.loadedResources
    //     const options = new MaterialTypeFetchOptions()
    //     options.withPropertyAssignments()
    //     options.withValidationPlugin()
    //     return options
    //   },
    // },

  // getters: {
  //   isLoggedIn() {
  //     return this.sessionToken !== null
  //   },
  // },
  },
})
