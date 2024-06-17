/*
The store is used to fetch, create, update and delete spaces.
Spaces are used to group projects and experiments.
*/

import { defineStore } from 'pinia'
import openbis from './openbis.esm'

export const useSpaceStore = defineStore('spaces', {
  actions: {
    async getAllSpaces(): Promise< openbis.Space[] > {
      const criteria = new openbis.SpaceSearchCriteria()
      const fo = new openbis.SpaceFetchOptions()
      const result = await useOpenBisStore().v3?.searchSpaces(criteria, fo)
      return result?.getObjects() || []
    },

    async getSpace(spaceId: openbis.ISpaceId): Promise<openbis.Space | undefined> {
      try {
      const sfo = new openbis.SpaceFetchOptions()
      const result = await useOpenBisStore().v3?.getSpaces(
        [spaceId], // Pass spaceId as an array
        sfo
      )
      return result ? result[0] : undefined
      } catch (error) {
      console.error('Error fetching space:', error)
      return undefined
      }
    },

    async createSpace(spaceCode: string, description: string | null = null): Promise<openbis.Space | undefined> {
      const creation = new openbis.SpaceCreation()
      
      creation.setCode(spaceCode)
      if (description)
        creation.setDescription(description)
      const response = await useOpenBisStore().v3?.createSpaces([creation])
      if (!response) {
        throw new Error('Failed to create space')
      }
      // Fetch the created space using the permId from the response to ensure the correct type is returned
      const fetchOptions = new openbis.SpaceFetchOptions()
      const createdSpaces = await useOpenBisStore().v3?.getSpaces(response.map(space => space.getPermId()), fetchOptions)
      return createdSpaces ? createdSpaces[0] : undefined
    },

    async updateSpace(space: openbis.SpaceUpdate): Promise<void> {
      const store = useOpenBisStore().v3
      if (!store) {
        throw new Error('OpenBis store is not available')
      }
      await store.updateSpaces([space])
    },

    async deleteSpace(spaceId: string, reason: string): Promise<void> { 
      console.log('deleteSpace', spaceId, reason)
      const sdo = new openbis.SpaceDeletionOptions()
      sdo.setReason(reason)
      await useOpenBisStore().v3?.deleteSpaces([new openbis.SpacePermId(spaceId)], sdo)
     
    },
  },
})
