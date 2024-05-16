import { defineStore } from 'pinia'
import openbis from './openbis.esm'

/*
The openbisStore is used to interact with the openBIS API.
It is used to login, logout, and fetch data from openBIS.
V3 instance created here, is used in all the other stores.
This ensures that only one instance of the v3 object is
created and used throughout the application.
*/

// TODO: Perist the V3 Object. https://prazdevs.github.io/pinia-plugin-persistedstate/guide/limitations.html
 
export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    v3: null as openbis.openbis | null,
    sessionToken: null as string | null,
  }),

  actions: {
    async initialize() {
      try {
        this.v3 = await new openbis.openbis()
        console.log('🚀 ~ initialize ~ this.v3:', this.v3)
      } catch (error) {
        console.error('Error initializing v3 object:', error)
      }
    },

    async autoLogin() {
      try {
        await this.login('admin', '123456789')
      } catch (error) {
        console.error('Error auto logging in:', error)
      }
    },

    async login(username: string, password: string) {
      try {
        if (!this.v3)
          throw new Error('v3 object not initialized')

        this.sessionToken = await this.v3.login(username, password)
        console.log('🚀 ~ login ~ sessionToken:', this.sessionToken)
      } catch (error) {
        console.error('Error logging in:', error)
      }
    },
    
    async logout() {
      try {
        if (!this.v3)
          throw new Error('v3 object not initialized')

        await this.v3.logout()
        console.log('Logged out successfully')
      } catch (error) {
        console.error('Error logging out:', error)
      }
    },
  },

  getters: {
    async getSessionInformation(state): Promise<string | null> {
      try {
        return await state.v3?.getSessionInformation()
      } catch (error) {
        console.error('Error getting session information:', error)
        return null
      }
    },
    async isLoggedIn(state): Promise<boolean> {
      try {
        if (await this.getSessionInformation)
          return true
        return false
      } catch (error) {
        console.error('Error checking if logged in:', error)
        return false
      }
    },
    
  },
  persist: true
})
