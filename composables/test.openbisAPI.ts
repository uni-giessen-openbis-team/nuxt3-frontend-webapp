// Rulle to convert with chat: Write this in pinia js Mehtod. The mehtods with the same name, sould be managed inside one funciton. Don't use try catch and seperate functions with comma. Dont use a session token. The v3 object already has it. Only show converted mehtods. Load the Classes that are used in the functions with: const { Class1, Class2 } = this.loadedResources. Return only the code for all the methods.
import  {Space} from './APItypes.js'
import { defineStore } from 'pinia'
import { resourcesToLoad } from './openBisResources.js'
import type {LoadedResources} from './openBisResources.js' 

export const useOpenBisStore = defineStore('openBis', {
  state: () => ({
    resourcesToLoad,
    loadedResources: {} as LoadedResources,
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
        this.initializeProxy()
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


    initializeProxy() {
      this.v3 = new Proxy(this.v3, {
        get: (target, prop) => {
          if (typeof target[prop] === 'function') {
            return (...args) => this.promise(target[prop](...args));
          }
          return target[prop];
        },
      });
    },


    async login() {
      await this.loadV3API()
      const loginResult = await this.v3.login('admin', 'admin')
      this.sessionToken = loginResult.sessionToken
      console.log('🚀 ~ file: openbisAPI.js:17 ~ loadV3API ~ this.openbisInstance:', this.v3)
    },
    },
  
})