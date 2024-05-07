/* 
The openbisStore is used to interact with the openBIS API. 
It is used to login, logout, and fetch data from openBIS.
V3 instance created here, is used in all the other stores. 
This ensures that only one instance of the v3 object is 
created and used throughout the application.
*/
import  openbis  from '@bschwab/types-api-openbis';
import {defineStore} from 'pinia'

export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    v3: openbis.openbis,
    sessionToken: null as string | null,
  }),

  actions: {
    async initialize() {
       this.v3 = await new openbis.openbis()
       await this.autoLogin()
    },

    async autoLogin() {
      await this.login('admin', 'whatever_value')
    },

    async login(username:string, password:string) {
      // Perform login; on success, update isLoggedIn
      if (!this.v3) {
        throw new Error('v3 object not initialized')
      }
      this.sessionToken = await this.v3.login(username, password)
      console.log("🚀 ~ login ~ sessionToken:", this.sessionToken)
    },

    async logout()  {
      if (!this.v3) {
        throw new Error('v3 object not initialized')
      }
      // Perform logout; on success, update isLoggedIn
      await this.v3.logout()
      console.log('Logged out successfully')
    },
  },
  
  getters: {
    getSessionToken(state) : string | null{
      return state.sessionToken
    },
  },
})

