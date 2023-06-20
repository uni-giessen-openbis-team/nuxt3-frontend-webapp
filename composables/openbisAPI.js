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
          this
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
    // Samples methods
    async createSample(typeId, spaceId, experimentId, code) {
      try {
        const sampleCreation = {
          typeId,
          spaceId,
          experimentId,
          code,
        }

        const permIds = await new Promise((resolve, reject) => {
          this.openbisInstance.createSamples([sampleCreation])
            .done(resolve)
            .fail(reject)
        })

        console.log('Perm ids: ', JSON.stringify(permIds))

        return permIds
      }
      catch (error) {
        console.error('Error creating sample:', error)
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
  },
  getters: {
    isLoggedIn() {
      return this.sessionToken !== null
    },
  },
})
