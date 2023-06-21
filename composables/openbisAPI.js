import { defineStore } from 'pinia'
import { resourcesToLoad } from './openBisResources.js'

export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    resourcesToLoad,
    loadedResources: {},
    openbisInstance: null,
    sessionToken: null,

  }),
  actions: {
    async loadV3API() {
      console.log('loadV3API')
      console.log('🚀 ~ file: openbisAPI.js:17 ~ loadV3API ~ this.openbisInstance:', this.openbisInstance)
      if (!this.openbisInstance) {
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
        this.openbisInstance = new this.loadedResources.openbis()
        console.log('🚀 ~ file: openbisAPI.js:17 ~ loadV3API ~ this.openbisInstance:', this.openbisInstance)
      }
    },
    // Login methods
    async login(user, password) {
      try {
        const sessionToken = await new Promise((resolve, reject) => {
          this.openbisInstance.login(user, password)
            .done((result) => {
              resolve(result)
            })
            .fail(reject)
        })
        console.log('token result:', sessionToken)
        this.sessionToken = sessionToken
      }
      catch (error) {
        console.error('Login error:', error)
        throw error
      }
    },
    async getSessionInformation() {
      try {
        const sessionInformation = await new Promise((resolve, reject) => {
          this.openbisInstance.getSessionInformation()
            .done(resolve)
            .fail(reject)
        })
        console.log('User Name: ', sessionInformation.userName)
        console.log('Home Group: ', sessionInformation.homeGroupCode)
        console.log('Person: ', sessionInformation.person)
        console.log('Creator Person: ', sessionInformation.creatorPerson)
        return sessionInformation
      }
      catch (error) {
        console.error('Error getting session information:', error)
        throw error
      }
    },

    // SearchExample
    async searchSamples(spaceCode, sampleTypeCode) {
      try {
        const criteria = new this.loadedResources.SampleSearchCriteria()
        criteria.withSpace().withCode().thatEquals(spaceCode)
        criteria.withType().withCode().thatEquals(sampleTypeCode)

        const fetchOptions = new this.loadedResources.SampleFetchOptions()
        fetchOptions.withProperties()

        const result = await new Promise((resolve, reject) => {
          this.openbisInstance.searchSamples(criteria, fetchOptions)
            .done(resolve)
            .fail(reject)
        })

        result.getObjects().forEach((sample) => {
          // because we asked for properties via fetch options we can access them here, otherwise NotFetchedException would be thrown by getProperties method
          console.log(`Sample ${sample.getIdentifier()} has properties: ${JSON.stringify(sample.getProperties())}`)
        })
        return result.getObjects()
      }
      catch (error) {
        console.error('Error searching samples:', error)
        throw error
      }
    },

    // Samples methods
    // sampleTypeCode - A type of samples to be created/updated.
    // properties - A map of properties to be set on the sample. maybe the sample data goes here
    // TODO: Test the function

    async createSampleEntry(sampleTypeCode, spaceCode, projectCode, experimentName, properties = {}) {
      try {
        const experimentCode = `${spaceCode}/${projectCode}/${experimentName}`
        const sample = new this.loadedResources.SampleCreation()
        sample.setTypeId(new this.loadedResources.EntityTypePermId(sampleTypeCode))
        sample.setSpaceId(new this.loadedResources.SpacePermId(spaceCode))
        sample.setExperimentId(new this.loadedResources.ExperimentIdentifier(experimentCode))

        // If the sample code is provided, set it
        if (properties.sampleCode) {
          sample.setCode(properties.sampleCode)
          delete properties.sampleCode // Delete the property to prevent setting it again
        }

        // Loop through the remaining properties (if any) and set them
        for (const property in properties) {
          if (properties.hasOwnProperty(property))
            sample.setProperty(property, properties[property])
        }

        return new Promise((resolve, reject) => {
          this.openbisInstance.createSamples([sample])
            .done(resolve)
            .fail(reject)
        })
      }
      catch (error) {
        console.error('Error creating sample entry:', error)
        throw error
      }
    },

    searchSpaces() {
      const criteria = new this.loadedResources.SpaceSearchCriteria()
      const fo = new this.loadedResources.SpaceFetchOptions()

      return new Promise((resolve, reject) => {
        this.openbisInstance.searchSpaces(criteria, fo).done(resolve).fail(reject)
      })
    },
    // searchProjects() {
    //   const criteria = new this.loadedResources.ProjectSearchCriteria()
    //   const fo = new this.loadedResources.ProjectFetchOptions()

    //   return new Promise((resolve, reject) => {
    //     this.openbisInstance.searchProjects(criteria, fo).done(resolve).fail(reject)
    //   })
    // },
  },
  getters: {
    isLoggedIn() {
      return this.sessionToken !== null
    },
  },
})
