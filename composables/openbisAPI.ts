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

    login(user, password) {
      return this.promise(this.v3.login(user, password))
        .then((sessionToken) => {
          this.sessionToken = sessionToken
          return sessionToken
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

    getAuthorizationGroups(ids, fo) {
      return this.promise(this.v3.getAuthorizationGroups(ids, fo))
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

    executeOperations(operations, options) {
      return this.promise(this.v3.executeOperations(operations, options))
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

  },
  getters: {
    isLoggedIn() {
      return this.sessionToken !== null
    },
  },
})
