//@ts-nocheck

import { defineStore } from 'pinia'


export const usePersonStore = defineStore('person',{
    state:() => ({
    
    }),
    actions : {
      listPersons(criteria , options ) {
        try {
          const persons =  useOpenBisStore().v3.searchPersons(criteria   , options)
          return persons.objects
        }
        catch (error) {
          console.error(error)
          return []
        }
      },

      listPersonsWithCriteria({ criteria }) {
        return this.listPersons({ criteria, options: fetchPersonCompletely() })
      },

      listPersonsWithToken() {
        const { PersonSearchCriteria } = v3
        return this.listPersons({ criteria: new PersonSearchCriteria(), options: fetchPersonCompletely() })
      },

      async listPersonsOfSpace(space: Space | null): searchResult {
        try {
          const criteria = new openbis.RoleAssignmentSearchCriteria()
          criteria.withSpace().withCode().thatEquals(space.code)
          const roleAssignments = await useOpenBisStore().v3.searchRoleAssignments(criteria, fetchRoleAssignmentWithSpaceAndUser())
          const listOfPers = roleAssignments
          return listOfPers
        }
        catch (error) {
          console.error(`${error.constructor.name}: ${error.message}`)
          console.warn(`listPersonsOfSpace(${space}) failed and returned an empty list.`)
          return []
        }
      },

      async listPersonsOfProject({ project }) {
        const criteria = new openbis.RoleAssignmentSearchCriteria().withOrOperator()
        criteria.withProject().withId().thatEquals(project.getIdentifier())
        criteria.withSpace().withId().thatEquals(project.getSpace().getPermId())
        const results = await  useOpenBisStore().v3.searchRoleAssignments(
          criteria,
          fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely(),
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

      async listPersonsOfProjectById({ projectId }) {
        const project = await this.getProject(projectId)
        return this.listPersonsOfProject(project)
      },

      async getPerson({ userId, options = fetchPersonCompletely() }) {
        const result = await useOpenBisStore().v3.getPersons(
          [userId],
          options,
        )
        return result.get(userId)
      },

      preparePersonCreation({ userId, spaceId }): creationType {
        const creation = new openbis.PersonCreation()
        creation.setUserId(userId)
        if (spaceId)
          creation.setSpaceId(spaceId)
        return creation
      },

      async createPerson(creation: creationType) {
        const result = await  useOpenBisStore().v3.createPersons([creation])
        return result[0]
      },

      async isPersonAdmin({ personId, userId, person, spaceId, projectId }) {
        if (personId || userId) {
          const { PersonPermId, PersonSearchCriteria, Role, RoleLevel } = this.loadedResources
          personId = personId || new PersonPermId(userId)
          const criteria = new PersonSearchCriteria()
          criteria.withId().thatEquals(personId)
          const persons = await  useOpenBisStore().v3.searchPersons(
            criteria,
            fetchPersonCompletely(), 
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
            const { Role, RoleLevel } = this.loadedResources

            for (const role of person.getRoleAssignments()) {
              if (role.getRoleLevel().equals(RoleLevel.INSTANCE) && role.getRole().equals(Role.ADMIN))
                return true
            }
          }
          catch (error) {
            return this.isPersonAdmin({ personId: person.getPermId() })
          }
        }

        if (spaceId || projectId) {
          if (await this.isPersonAdmin({ personId }))
            return true

          const { RoleAssignmentSearchCriteria, Role, RoleLevel } = this.loadedResources
          const criteria = new RoleAssignmentSearchCriteria()
          criteria.withSpace().withId().thatEquals(spaceId)
          criteria.withProject().withId().thatEquals(projectId)

          const result = await  useOpenBisStore().v3.searchRoleAssignments(
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


      /* 
      RoleAssignment API Methods
       */

      async listRoleAssignments({ criteria, options }) {
        try {
          const result = await  useOpenBisStore().v3.searchRoleAssignments(criteria, options)
          return result.getObjects()
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`listRoleAssignments(<TOKEN>,${criteria},${options}) failed and returned an empty list.`)
          return []
        }
      },
      async getRoleAssignment({ roleAssignmentId, options }) {
        try {
          const result = await  useOpenBisStore().v3.getRoleAssignments([roleAssignmentId], options)
          return result.get(roleAssignmentId)
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`getRoleAssignment(<TOKEN>,${roleAssignmentId},${options}) failed and returned null.`)
          return null
        }
      },

      async getRoleAssignments({ roleAssignmentIds }) {
        try {
          return await  useOpenBisStore().v3.getRoleAssignments(roleAssignmentIds, this.fetchRoleAssignmentCompletely())
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

      async createRoleAssignment({ creation }) {
        try {
          return (await  useOpenBisStore().v3.createRoleAssignments([creation]))[0]
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`createRoleAssignment(<TOKEN>,${creation}) failed and returned null.`)
          return null
        }
      },

      async createRoleAssignments({ creations }) {
        try {
          return await  useOpenBisStore().v3.createRoleAssignments(creations)
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`createRoleAssignments(<TOKEN>,${creations}) failed and returned null.`)
          return null
        }
      },

      async deleteRoleAssignment({ roleAssignmentId, reason }) {
        try {
          const options = new RoleAssignmentDeletionOptions().setReason(reason)
          await  useOpenBisStore().v3.deleteRoleAssignments([roleAssignmentId], options)
          return true
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`deleteRoleAssignment(<TOKEN>,${roleAssignmentId},${reason}) failed and returned false.`)
          return false
        }
      },



      /* ----------------------------------------------------------------------------------------- */
      /* ----- AuthorizationGroup API Methods ---------------------------------------------------- */
      /* ----------------------------------------------------------------------------------------- */

      async getAuthorizationGroups({

        criteria = new AuthorizationGroupSearchCriteria(),
        options = this.fetchAuthorizationGroupCompletely(),
        authorizationGroupId,
      } = {}) {
        try {
          if (authorizationGroupId) {
            let result
            if (Array.isArray(authorizationGroupId)) {
              result = await  useOpenBisStore().v3.getAuthorizationGroups(

                authorizationGroupId,
                options,
              )
            }
            else {
              result = await  useOpenBisStore().v3.getAuthorizationGroups(

                [authorizationGroupId],
                options,
              )
              result = result.get(authorizationGroupId)
            }

            return result
          }
          else {
            const result = await  useOpenBisStore().v3.searchAuthorizationGroups(criteria, options)
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

      async createAuthorizationGroup({ creation }) {
        try {
          const result = await  useOpenBisStore().v3.createAuthorizationGroups([creation])
          return result[0]
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`createAuthorizationGroup(<TOKEN>,${creation}) failed and returned null.`)
          return null
        }
      },

      async createAuthorizationGroups({ creations }) {
        try {
          return await  useOpenBisStore().v3.createAuthorizationGroups(creations)
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`createAuthorizationGroups(<TOKEN>,${creations}) failed and returned null.`)
          return null
        }
      },

      async updateAuthorizationGroup({ authorizationGroupId, description, users }) {
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
          await  useOpenBisStore().v3.updateAuthorizationGroups([update])
          return true
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`updateAuthorizationGroup(<TOKEN>,${update}) failed and returned null.`)
          return false
        }
      },

      async deleteAuthorizationGroup({ authorizationGroupId, reason }) {
        try {
          const options = new AuthorizationGroupDeletionOptions().setReason(reason)
          await  useOpenBisStore().v3.deleteAuthorizationGroups([authorizationGroupId], options)
          return true
        }
        catch (error) {
          console.error(`${error.name}: ${error.message}`)
          console.warn(`deleteAuthorizationGroup(<TOKEN>,${authorizationGroupId},${reason}) failed and returned false.`)
          return false
        }
      },
    }
})

