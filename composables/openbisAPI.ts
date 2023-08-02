import { defineStore } from 'pinia'
import { resourcesToLoad } from './openBisResources.js'
export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    resourcesToLoad,
    loadedResources: {},
    v3: null,
    sessionToken: null,

  }),
  actions: {
    async loadV3API() {
      console.log('loadV3API')
      if (!this.v3) {
        const promises = this.resourcesToLoad.map((fullName) => {
          return new Promise((resolve) => {
            require([fullName], (resource) => {
              const shortName = fullName.includes('/') ? fullName.substring(fullName.lastIndexOf('/') + 1) : fullName
              this.loadedResources[shortName] = resource
              resolve()
            })
          })
        })

        await Promise.all(promises)
        this.v3 = new this.loadedResources.openbis()
        console.log('🚀 ~ file: openbisAPI.js:17 ~ loadV3API ~ this.openbisInstance:', this.v3)
      }
    },
    promise(dfd) {
      return new Promise((resolve, reject) => {
        dfd.then(
          (result) => {
            resolve(result)
          },
          (error) => {
            reject(error)
          },
        )
      })
    },

    getSessionInformation() {
      return this.promise(this.v3.getSessionInformation())
    },

    getServerInformation() {
      return this.promise(this.v3.getServerInformation())
    },

    getServerPublicInformation() {
      return this.promise(this.v3.getServerPublicInformation())
    },

    logout() {
      this.sessionToken = null
      return this.promise(this.v3.logout())
    },

    getSpaces(ids, fo) {
      return this.promise(this.v3.getSpaces(ids, fo))
    },
    getProjects(ids, fo) {
      return this.promise(this.v3.getProjects(ids, fo))
    },

    getExperiments(ids, fo) {
      return this.promise(this.v3.getExperiments(ids, fo))
    },

    getSamples(ids, fo) {
      return this.promise(this.v3.getSamples(ids, fo))
    },

    getDataSets(ids, fo) {
      return this.promise(this.v3.getDataSets(ids, fo))
    },

    getPlugins(ids, fo) {
      return this.promise(this.v3.getPlugins(ids, fo))
    },

    getQueries(ids, fo) {
      return this.promise(this.v3.getQueries(ids, fo))
    },

    getPropertyTypes(ids, fo) {
      return this.promise(this.v3.getPropertyTypes(ids, fo))
    },

    getPersons(ids, fo) {
      return this.promise(this.v3.getPersons(ids, fo))
    },

    updatePersons(updates) {
      return this.promise(this.v3.updatePersons(updates))
    },

    searchSpaces(criteria, fo) {
      return this.promise(this.v3.searchSpaces(criteria, fo))
    },

    searchProjects(criteria, fo) {
      return this.promise(this.v3.searchProjects(criteria, fo))
    },

    searchPropertyTypes(criteria, fo) {
      return this.promise(this.v3.searchPropertyTypes(criteria, fo))
    },

    searchPlugins(criteria, fo) {
      return this.promise(this.v3.searchPlugins(criteria, fo))
    },

    searchPersonalAccessTokens(criteria, fo) {
      return this.promise(this.v3.searchPersonalAccessTokens(criteria, fo))
    },

    searchQueries(criteria, fo) {
      return this.promise(this.v3.searchQueries(criteria, fo))
    },

    searchQueryDatabases(criteria, fo) {
      return this.promise(this.v3.searchQueryDatabases(criteria, fo))
    },

    searchMaterials(criteria, fo) {
      return this.promise(this.v3.searchMaterials(criteria, fo))
    },

    searchSamples(criteria, fo) {
      return this.promise(this.v3.searchSamples(criteria, fo))
    },

    searchExperiments(criteria, fo) {
      return this.promise(this.v3.searchExperiments(criteria, fo))
    },

    searchDataSets(criteria, fo) {
      return this.promise(this.v3.searchDataSets(criteria, fo))
    },

    searchVocabularies(criteria, fo) {
      return this.promise(this.v3.searchVocabularies(criteria, fo))
    },

    searchVocabularyTerms(criteria, fo) {
      return this.promise(this.v3.searchVocabularyTerms(criteria, fo))
    },

    searchPersons(criteria, fo) {
      return this.promise(this.v3.searchPersons(criteria, fo))
    },

    searchAuthorizationGroups(criteria, fo) {
      return this.promise(this.v3.searchAuthorizationGroups(criteria, fo))
    },

    searchPropertyAssignments(criteria, fo) {
      return this.promise(this.v3.searchPropertyAssignments(criteria, fo))
    },

    searchEvents(criteria, fo) {
      return this.promise(this.v3.searchEvents(criteria, fo))
    },

    getSampleTypes(ids, fo) {
      return this.promise(this.v3.getSampleTypes(ids, fo))
    },

    getExperimentTypes(ids, fo) {
      return this.promise(this.v3.getExperimentTypes(ids, fo))
    },

    getDataSetTypes(ids, fo) {
      return this.promise(this.v3.getDataSetTypes(ids, fo))
    },

    getMaterialTypes(ids, fo) {
      return this.promise(this.v3.getMaterialTypes(ids, fo))
    },

    getVocabularies(ids, fo) {
      return this.promise(this.v3.getVocabularies(ids, fo))
    },

    getOperationExecutions(ids, fo) {
      return this.promise(this.v3.getOperationExecutions(ids, fo))
    },

    updateSampleTypes(updates) {
      return this.promise(this.v3.updateSampleTypes(updates))
    },

    updateExperimentTypes(updates) {
      return this.promise(this.v3.updateExperimentTypes(updates))
    },

    updateDataSetTypes(updates) {
      return this.promise(this.v3.updateDataSetTypes(updates))
    },

    updateMaterialTypes(updates) {
      return this.promise(this.v3.updateMaterialTypes(updates))
    },

    searchSampleTypes(criteria, fo) {
      return this.promise(this.v3.searchSampleTypes(criteria, fo))
    },

    searchExperimentTypes(criteria, fo) {
      return this.promise(this.v3.searchExperimentTypes(criteria, fo))
    },

    searchDataSetTypes(criteria, fo) {
      return this.promise(this.v3.searchDataSetTypes(criteria, fo))
    },

    searchMaterialTypes(criteria, fo) {
      return this.promise(this.v3.searchMaterialTypes(criteria, fo))
    },

    deleteSampleTypes(ids, options) {
      return this.promise(this.v3.deleteSampleTypes(ids, options))
    },

    deleteExperimentTypes(ids, options) {
      return this.promise(this.v3.deleteExperimentTypes(ids, options))
    },

    deleteDataSetTypes(ids, options) {
      return this.promise(this.v3.deleteDataSetTypes(ids, options))
    },

    deleteMaterialTypes(ids, options) {
      return this.promise(this.v3.deleteMaterialTypes(ids, options))
    },

    evaluatePlugin(options) {
      return this.promise(this.v3.evaluatePlugin(options))
    },

    executeQuery(id, options) {
      return this.promise(this.v3.executeQuery(id, options))
    },

    executeSql(sql, options) {
      return this.promise(this.v3.executeSql(sql, options))
    },

    executeOperations(criteria, options) {
      return this.promise(this.v3.executeOperations(criteria, options))
    },

    /* ----- Person API Methods ---------------------------------------------------------------- */

    listPersons({ sessionToken, criteria, options }) {
      try {
        const persons = this.v3.searchPersons(sessionToken, criteria, options)
        return persons.objects
      }
      catch (error) {
        console.error(`${error.constructor.name}: ${error.message}`)
        console.warn(`listPersons(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
        return []
      }
    },

    listPersonsWithCriteria({ sessionToken, criteria }) {
      return this.listPersons({ sessionToken, criteria, options: this.fetchPersonCompletely() })
    },

    listPersonsWithToken(sessionToken) {
      const { PersonSearchCriteria } = this.loadedResources
      return this.listPersons({ sessionToken, criteria: new PersonSearchCriteria(), options: this.fetchPersonCompletely() })
    },

    listPersonsOfSpace({ sessionToken, spaceCode }) {
      try {
        const { RoleAssignmentSearchCriteria } = this.loadedResources
        const criteria = new RoleAssignmentSearchCriteria().withSpace().withCode().thatEquals(spaceCode)
        const roleAssignments = this.v3.searchRoleAssignments(sessionToken, criteria, this.fetchRoleAssignmentWithSpaceAndUser())
        return roleAssignments.objects.map(roleAssignment => roleAssignment.user)
      }
      catch (error) {
        console.error(`${error.constructor.name}: ${error.message}`)
        console.warn(`listPersonsOfSpace(<TOKEN>,${spaceCode}) failed and returned an empty list.`)
        return []
      }
    },

    async listPersonsOfProject({ sessionToken, project }) {
      const criteria = new RoleAssignmentSearchCriteria().withOrOperator()
      criteria.withProject().withId().thatEquals(project.getIdentifier())
      criteria.withSpace().withId().thatEquals(project.getSpace().getPermId())

      const results = await this.v3.searchRoleAssignments(
        sessionToken,
        criteria,
        FetchOptionsUtil.fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
      )

      const projectMembers = new Set() // No duplicates
      results.getObjects().forEach((ra) => {
        if (Role.OBSERVER.equals(ra.getRole()) || (RoleLevel.INSTANCE.equals(ra.getRoleLevel()) && Role.ADMIN.equals(ra.getRole())))
          return

        if (ra.getUser() != null)
          projectMembers.add(ra.getUser())
        else
          projectMembers.addAll(ra.getAuthorizationGroup().getUsers())
      })

      return Array.from(projectMembers)
    },

    async listPersonsOfProjectById({ sessionToken, projectId }) {
      const project = await this.getProject(sessionToken, projectId)
      return this.listPersonsOfProject(sessionToken, project)
    },

    async getPerson({ sessionToken, userId, options = this.fetchPersonCompletely() }) {
      const result = await this.v3.getPersons(
        sessionToken,
        [userId],
        options,
      )

      return result.get(userId)
    },

    preparePersonCreation({ userId, spaceId }) {
      const creation = new PersonCreation()
      creation.setUserId(userId)
      creation.setSpaceId(spaceId)
      return creation
    },

    preparePersonCreationWithoutSpace({ userId }) {
      const creation = new PersonCreation()
      creation.setUserId(userId)
      return creation
    },

    async createPerson({ sessionToken, creation }) {
      const result = await this.v3.createPersons(sessionToken, [creation])
      return result[0]
    },

    async isPersonAdmin({ sessionToken, personId, userId, person, spaceId, projectId }) {
      if (personId || userId) {
        personId = personId || new PersonPermId(userId)
        const criteria = new PersonSearchCriteria()
        criteria.withId().thatEquals(personId)

        const persons = await this.v3.searchPersons(
          sessionToken,
          criteria,
          FetchOptionsUtil.fetchPersonCompletely(),
        )

        if (persons.getTotalCount() < 1)
          throw new Error(`Could not find person with user id: ${personId}`)

        for (const role of persons.getObjects()[0].getRoleAssignments()) {
          if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
            return true
        }
      }

      if (person) {
        try {
          for (const role of person.getRoleAssignments()) {
            if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
              return true
          }
        }
        catch (error) {
          return this.isPersonAdmin({ sessionToken, personId: person.getPermId() })
        }
      }

      if (spaceId || projectId) {
        if (await this.isPersonAdmin({ sessionToken, personId }))
          return true

        const criteria = new RoleAssignmentSearchCriteria()
        criteria.withSpace().withId().thatEquals(spaceId)
        criteria.withProject().withId().thatEquals(projectId)

        const result = await this.v3.searchRoleAssignments(
          sessionToken,
          criteria,
          this.fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
        )

        for (const roleAssignment of result.getObjects()) {
          if (roleAssignment.getRole() === Role.ADMIN && roleAssignment.getRoleLevel() === RoleLevel.SPACE) {
            if (roleAssignment.getUser() && roleAssignment.getUser().getPermId().equals(personId))
              return true

            if (roleAssignment.getAuthorizationGroup() && roleAssignment.getAuthorizationGroup().getUsers().map(user => user.getPermId()).includes(personId))
              return true
          }
        }
      }

      return false
    },

    /* ----------------------------------------------------------------------------------------- */
    /* ----- AuthorizationGroup API Methods ---------------------------------------------------- */
    /* ----------------------------------------------------------------------------------------- */

    async getAuthorizationGroups({
      sessionToken,
      criteria = new AuthorizationGroupSearchCriteria(),
      options = FetchOptionsUtil.fetchAuthorizationGroupCompletely(),
      authorizationGroupId,
    } = {}) {
      try {
        if (authorizationGroupId) {
          let result
          if (Array.isArray(authorizationGroupId)) {
            result = await this.v3.getAuthorizationGroups(
              sessionToken,
              authorizationGroupId,
              options,
            )
          }
          else {
            result = await this.v3.getAuthorizationGroups(
              sessionToken,
              [authorizationGroupId],
              options,
            )
            result = result.get(authorizationGroupId)
          }

          return result
        }
        else {
          const result = await this.v3.searchAuthorizationGroups(sessionToken, criteria, options)
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
    },

    // Call prepareAuthorizationGroupCreation:
    // let group1 = prepareAuthorizationGroupCreation({ code: 'myCode', description: 'myDescription', userIds: ['id1', 'id2'] });
    // let group2 = prepareAuthorizationGroupCreation({ code: 'myCode2', description: 'myDescription2' });
    // let group3 = prepareAuthorizationGroupCreation({ code: 'myCode3' });

    prepareAuthorizationGroupCreation({
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
    },

    async createAuthorizationGroup({ sessionToken, creation }) {
      try {
        const result = await this.v3.createAuthorizationGroups(sessionToken, [creation])
        return result[0]
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`createAuthorizationGroup(<TOKEN>,${creation}) failed and returned null.`)
        return null
      }
    },

    async createAuthorizationGroups({ sessionToken, creations }) {
      try {
        return await this.v3.createAuthorizationGroups(sessionToken, creations)
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`createAuthorizationGroups(<TOKEN>,${creations}) failed and returned null.`)
        return null
      }
    },

    async updateAuthorizationGroup({ sessionToken, authorizationGroupId, description, users }) {
      const update = new AuthorizationGroupUpdate()
      update.setAuthorizationGroupId(authorizationGroupId)

      if (description)
        update.setDescription(description)

      if (users) {
        const action = new ListUpdateValue.ListUpdateAction()
        action.setItems(users)
        update.setUserIdActions([action])
      }

      try {
        await this.v3.updateAuthorizationGroups(sessionToken, [update])
        return true
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`updateAuthorizationGroup(<TOKEN>,${update}) failed and returned null.`)
        return false
      }
    },

    async deleteAuthorizationGroup({ sessionToken, authorizationGroupId, reason }) {
      try {
        const options = new AuthorizationGroupDeletionOptions().setReason(reason)
        await this.v3.deleteAuthorizationGroups(sessionToken, [authorizationGroupId], options)
        return true
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteAuthorizationGroup(<TOKEN>,${authorizationGroupId},${reason}) failed and returned false.`)
        return false
      }
    },

    /* ----------------------------------------------------------------------------------------- */
    /* ----- RoleAssignment API Methods -------------------------------------------------------- */
    /* ----------------------------------------------------------------------------------------- */

    async listRoleAssignments({ sessionToken, criteria, options }) {
      try {
        const result = await this.v3.searchRoleAssignments(sessionToken, criteria, options)
        return result.getObjects()
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`listRoleAssignments(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
        return []
      }
    },
    async getRoleAssignment({ sessionToken, roleAssignmentId, options }) {
      try {
        const result = await this.v3.getRoleAssignments(sessionToken, [roleAssignmentId], options)
        return result.get(roleAssignmentId)
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`getRoleAssignment(<TOKEN>,${roleAssignmentId},${options}) failed and returned null.`)
        return null
      }
    },

    async getRoleAssignments({ sessionToken, roleAssignmentIds }) {
      try {
        return await this.v3.getRoleAssignments(sessionToken, roleAssignmentIds, this.fetchRoleAssignmentCompletely())
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`getRoleAssignments(<TOKEN>,${roleAssignmentIds}) failed and returned null.`)
        return null
      }
    },

    prepareRoleAssignmentCreation({ role, spaceId, projectId, userId, authorizationGroupId }) {
      const creation = new RoleAssignmentCreation()
      creation.setRole(role)
      creation.setSpaceId(spaceId || null)
      creation.setProjectId(projectId || null)
      creation.setUserId(userId || null)
      creation.setAuthorizationGroupId(authorizationGroupId || null)
      return creation
    },

    async createRoleAssignment({ sessionToken, creation }) {
      try {
        return (await this.v3.createRoleAssignments(sessionToken, [creation]))[0]
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`createRoleAssignment(<TOKEN>,${creation}) failed and returned null.`)
        return null
      }
    },

    async createRoleAssignments({ sessionToken, creations }) {
      try {
        return await this.v3.createRoleAssignments(sessionToken, creations)
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`createRoleAssignments(<TOKEN>,${creations}) failed and returned null.`)
        return null
      }
    },

    async deleteRoleAssignment({ sessionToken, roleAssignmentId, reason }) {
      try {
        const options = new RoleAssignmentDeletionOptions().setReason(reason)
        await this.v3.deleteRoleAssignments(sessionToken, [roleAssignmentId], options)
        return true
      }
      catch (error) {
        console.error(`${error.name}: ${error.message}`)
        console.warn(`deleteRoleAssignment(<TOKEN>,${roleAssignmentId},${reason}) failed and returned false.`)
        return false
      }
    },


    

    login(user, password) {
      return this.promise(this.v3.login(user, password))
        .then((sessionToken) => {
          this.sessionToken = sessionToken
          return sessionToken
        })
    },

    // Vocabulary code is something like "SPECIES"
    async getVocabularyTerms(vocavularyCode) {
      const { VocabularyFetchOptions, VocabularyPermId } = this.loadedResources
      const fo = new VocabularyFetchOptions()
      fo.withRegistrator()
      fo.withTerms()
      const id = new VocabularyPermId(vocavularyCode)
      return await this.getVocabularies(id, fo)
    },

    // One space for each working group
    async getAllSpaces() {
      const { SpaceSearchCriteria, SpaceFetchOptions } = this.loadedResources
      const criteria = new SpaceSearchCriteria()
      const fo = new SpaceFetchOptions()
      return await this.searchSpaces(criteria, fo)
    },

    async prepareProjectCreation(projectCode, spaceCode, description) {
      const { ProjectCreation, SpacePermId } = this.loadedResources
      const creation = new ProjectCreation()
      creation.setCode(projectCode)
      creation.setSpaceId(new SpacePermId(spaceCode))
      creation.setDescription(description)
      return await creation
    },

    async createProject(projectCode, spaceCode, description) {
      const creation = await this.prepareProjectCreation(projectCode, spaceCode, description)
      return await this.v3.createProjects(creation)
    },

    // The main function
    // pass the sampleGroups in the right order. From top to bottom hiracy
    async createSamplesFromWizzard(projectContext, sampleGroups) {
      const { SampleCreation, EntityTypePermId, SpacePermId, CreationId } = this.loadedResources

      const createdSamples = []
      const sampleCreationsDict = {}

      for (const sampleList of sampleGroups) {
        for (const sample of sampleList) {
          const sampleCreation = new SampleCreation()
          sampleCreation.setTypeId(new EntityTypePermId(sample.sampleType))
          sampleCreation.setSpaceId(new SpacePermId(projectContext.space))
          sampleCreation.setCreationId(new CreationId(sample.secondaryName))

          // Iterate over conditions and set property for each
          for (const condition of sample.conditions) {
            for (const [key, value] of Object.entries(condition))
              sampleCreation.setProperty(key, value)
          }
          // sampleCreation.setCode('MY_SAMPLE_CODE')
          // sampleCreation.setExperimentId(new ExperimentIdentifier('/MY_SPACE_CODE/MY_PROJECT_CODE/MY_EXPERIMENT_CODE'))

          if (sample.parent) {
            // If the sample has a parent, directly get the parent's SampleCreation object from the dictionary
            const parentSampleCreation = sampleCreationsDict[sample.parent]
            if (parentSampleCreation) {
              sampleCreation.setParentIds([parentSampleCreation.getCreationId()])

              // Add the sample's creation ID to the parent's child IDs
              const parentChildIds = parentSampleCreation.getChildIds() || []
              parentChildIds.push(sampleCreation.getCreationId())
              parentSampleCreation.setChildIds(parentChildIds)
            }
            else { console.log('Parent sample not found') }
          }

          sample.sampleCreation = sampleCreation
          // Add the SampleCreation object to the dictionary
          sampleCreationsDict[sample.secondaryName] = sampleCreation
          createdSamples.push(sampleCreation)
        }
      }

      return await this.v3.createSamples([createdSamples[0]]).done((permIds) => {
        alert(`Perm ids: ${JSON.stringify(permIds)}`)
      })
      // return createdSamples
    },

    /// /////////////// FetchOptions ////////////////////////
    /// ///////////////// Person  ///////////////////////////
    fetchPersonCompletely() {
      const { PersonFetchOptions } = this.loadedResources
      const options = new PersonFetchOptions()
      options.withRegistrator()
      options.withSpace()
      options.withRoleAssignments()
      return options
    },

    fetchPersonWithSpace() {
      const { PersonFetchOptions } = this.loadedResources
      const options = new PersonFetchOptions()
      options.withSpaceUsing(this.fetchSpaceCompletely())
      return options
    },

    /// ///////////////// Role Assighnment /////////////
    fetchRoleAssignmentCompletely() {
      const { RoleAssignmentFetchOptions } = this.loadedResources
      const options = new RoleAssignmentFetchOptions()
      options.withRegistrator()
      options.withSpace()
      options.withProject()
      options.withUser()
      options.withAuthorizationGroup()
      return options
    },
    fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely() {
      const { RoleAssignmentFetchOptions } = this.loadedResources
      const options = new RoleAssignmentFetchOptions()
      options.withRegistrator()
      options.withSpace()
      options.withProject()
      options.withUserUsing(this.fetchPersonCompletely())
      options.withAuthorizationGroupUsing(this.fetchAuthorizationGroupWithUsers())
      return options
    },
    fetchRoleAssignmentWithSpaceAndUser() {
      const { RoleAssignmentFetchOptions } = this.loadedResources
      const options = new RoleAssignmentFetchOptions()
      options.withSpaceUsing(this.fetchSpaceCompletely())
      options.withUserUsing(this.fetchPersonCompletely())
      return options
    },

    fetchRoleAssignmentWithProjectAndUser() {
      const { RoleAssignmentFetchOptions } = this.loadedResources
      const options = new RoleAssignmentFetchOptions()
      options.withProjectUsing(this.fetchProjectCompletely())
      options.withUserUsing(this.fetchPersonCompletely())
      return options
    },
    /// ///////// Authorization group //////////////

    fetchAuthorizationGroupCompletely() {
      const { AuthorizationGroupFetchOptions } = this.loadedResources
      const options = new AuthorizationGroupFetchOptions()
      options.withRegistrator()
      options.withRoleAssignments()
      options.withUsers()
      return options
    },

    fetchAuthorizationGroupWithUsersCompletely() {
      const { AuthorizationGroupFetchOptions } = this.loadedResources
      const options = new AuthorizationGroupFetchOptions()
      options.withRegistrator()
      options.withRoleAssignments()
      options.withUsersUsing(this.fetchPersonCompletely())
      return options
    },

    fetchAuthorizationGroupWithUsers() {
      const { AuthorizationGroupFetchOptions } = this.loadedResources
      const options = new AuthorizationGroupFetchOptions()
      options.withUsersUsing(this.fetchPersonCompletely())
      return options
    },

    // Space
    fetchSpaceCompletely() {
      const { SpaceFetchOptions } = this.loadedResources
      const options = new SpaceFetchOptions()
      options.withRegistrator()
      options.withProjects()
      options.withSamples()
      return options
    },

    fetchSpaceWithProjectCompletely() {
      const { SpaceFetchOptions } = this.loadedResources
      const options = new SpaceFetchOptions()
      options.withRegistrator()
      options.withProjectsUsing(this.fetchProjectCompletely())
      options.withSamples()
      return options
    },

    /// //////////// Project ////////////////////////
    fetchProjectCompletely() {
      const { ProjectFetchOptions } = this.loadedResources
      const options = new ProjectFetchOptions()
      options.withRegistrator()
      options.withLeader()
      options.withSpace()
      options.withExperiments()
      options.withSamples()
      options.withAttachments()
      options.withHistory()
      options.withModifier()
      return options
    },

    fetchProjectWithCollections() {
      const { ProjectFetchOptions } = this.loadedResources
      const options = new ProjectFetchOptions()
      options.withRegistrator()
      options.withLeader()
      options.withSpace()
      options.withExperimentsUsing(this.fetchCollectionCompletely())
      options.withSamples()
      options.withAttachments()
      options.withHistory()
      options.withModifier()
      return options
    },
    /// ////////////// Collection ///////////
    fetchCollectionCompletely() {
      const { ExperimentFetchOptions } = this.loadedResources
      const options = new ExperimentFetchOptions()
      options.withRegistrator()
      options.withProject()
      options.withSamples()
      options.withDataSets()
      options.withAttachments()
      options.withHistory()
      options.withModifier()
      options.withMaterialProperties()
      options.withProperties()
      options.withTags()
      options.withType()
      return options
    },

    fetchCollectionWithProjectCompletely() {
      const { ExperimentFetchOptions } = this.loadedResources
      const options = new ExperimentFetchOptions()
      options.withRegistrator()
      options.withProjectUsing(this.fetchProjectCompletely())
      options.withSamples()
      options.withDataSets()
      options.withAttachments()
      options.withHistory()
      options.withModifier()
      options.withMaterialProperties()
      options.withProperties()
      options.withTags()
      options.withType()
      return options
    },

    fetchCollectionTypeCompletely() {
      const { ExperimentTypeFetchOptions } = this.loadedResources
      const options = new ExperimentTypeFetchOptions()
      options.withPropertyAssignments()
      options.withValidationPlugin()
      return options
    },

    /// ///////////// Sample ////////////////

    fetchObjectCompletely() {
      const { SampleFetchOptions } = this.loadedResources
      const options = new SampleFetchOptions()
      options.withRegistrator()
      options.withSpace()
      options.withProject()
      options.withExperiment()
      options.withDataSets()
      options.withAttachments()
      options.withComponents()
      options.withContainer()
      options.withHistory()
      options.withModifier()
      options.withMaterialProperties()
      options.withProperties()
      options.withTags()
      options.withType()
      options.withParents()
      options.withChildren()
      // options.withSampleProperties();  // ?
      return options
    },

    fetchObjectWithParentsAndChildrenCompletely() {
      const { SampleFetchOptions } = this.loadedResources
      const options = new SampleFetchOptions()
      options.withRegistrator()
      options.withSpace()
      options.withProject()
      options.withExperiment()
      options.withDataSets()
      options.withAttachments()
      options.withComponents()
      options.withContainer()
      options.withHistory()
      options.withModifier()
      options.withMaterialProperties()
      options.withProperties()
      options.withTags()
      options.withType()
      options.withParentsUsing(this.fetchObjectCompletely())
      options.withChildrenUsing(this.fetchObjectCompletely())
      // options.withSampleProperties();  // ?
      return options
    },

    fetchObjectWithParentsAndChildrenRecursive() {
      const { SampleFetchOptions } = this.loadedResources
      const options = new SampleFetchOptions()
      options.withRegistrator()
      options.withSpace()
      options.withProject()
      options.withExperiment()
      options.withDataSets()
      options.withAttachments()
      options.withComponents()
      options.withContainer()
      options.withHistory()
      options.withModifier()
      options.withMaterialProperties()
      options.withProperties()
      options.withTags()
      options.withType()
      options.withParentsUsing(options)
      options.withChildrenUsing(options)
      // options.withSampleProperties();  // ?
      return options
    },

    fetchObjectTypeCompletely() {
      const { SampleTypeFetchOptions } = this.loadedResources
      const options = new SampleTypeFetchOptions()
      options.withPropertyAssignments()
      options.withSemanticAnnotations()
      options.withValidationPlugin()
      return options
    },
    /* ----- DataSet / DataSetFile -------------------------------------------------------- */
    fetchDataSetCompletely() {
      const { DataSetFetchOptions } = this.loadedResources
      const options = new DataSetFetchOptions()
      options.withRegistrator()
      options.withExperiment()
      options.withSample()
      options.withDataStore()
      options.withComponents()
      options.withContainers()
      options.withHistory()
      options.withModifier()
      options.withMaterialProperties()
      options.withProperties()
      options.withTags()
      options.withType()
      options.withLinkedData()
      options.withParents()
      options.withChildren()
      options.withPhysicalData()
      return options
    },

    /* ----- Vocabulary / VocabularyTerm -------------------------------------------------- */
    fetchVocabularyCompletely() {
      const { VocabularyFetchOptions } = this.loadedResources
      const options = new VocabularyFetchOptions()
      options.withRegistrator()
      options.withTerms()
      return options
    },

    fetchVocabularyTermCompletely() {
      const { VocabularyTermFetchOptions } = this.loadedResources
      const options = new VocabularyTermFetchOptions()
      options.withRegistrator()
      options.withVocabulary()
      return options
    },

    /* ----- PropertyAssignment / PropertyType -------------------------------------------- */
    fetchPropertyTypeCompletely() {
      const { PropertyTypeFetchOptions } = this.loadedResources
      const options = new PropertyTypeFetchOptions()
      options.withRegistrator()
      options.withVocabulary()
      options.withSemanticAnnotations()
      options.withMaterialType()
      return options
    },

    fetchPropertyTypeWithVocabularyAndTerms() {
      const { PropertyTypeFetchOptions } = this.loadedResources
      const options = new PropertyTypeFetchOptions()
      options.withVocabularyUsing(this.fetchVocabularyCompletely())
      return options
    },

    fetchPropertyAssignmentCompletely() {
      const { PropertyAssignmentFetchOptions } = this.loadedResources
      const options = new PropertyAssignmentFetchOptions()
      options.withRegistrator()
      options.withPropertyType()
      options.withEntityType()
      options.withPlugin()
      return options
    },

    fetchPropertyAssignmentWithPropertyType() {
      const { PropertyAssignmentFetchOptions } = this.loadedResources
      const options = new PropertyAssignmentFetchOptions()
      options.withPropertyTypeUsing(this.fetchPropertyTypeCompletely())
      return options
    },

    /* ----- Material / MaterialType ------------------------------------------------------ */
    fetchMaterialCompletely() {
      const { MaterialFetchOptions } = this.loadedResources
      const options = new MaterialFetchOptions()
      options.withRegistrator()
      options.withHistory()
      options.withProperties()
      options.withMaterialProperties()
      options.withTags()
      options.withType()
      return options
    },

    fetchMaterialTypeCompletely() {
      const { MaterialTypeFetchOptions } = this.loadedResources
      const options = new MaterialTypeFetchOptions()
      options.withPropertyAssignments()
      options.withValidationPlugin()
      return options
    },
  },

  getters: {
    isLoggedIn() {
      return this.sessionToken !== null
    },
  },
})
