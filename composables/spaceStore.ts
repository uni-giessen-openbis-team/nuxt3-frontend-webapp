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
      const sfo = new openbis.SpaceFetchOptions()
      const result = await useOpenBisStore().v3?.getSpaces(
        [spaceId], // Pass spaceId as an array
        sfo
      )
      return result?.getObjects()[0]
    },

    async createSpace(spaceCode: string, description: string | null = null): Promise<openbis.Space | undefined> {
      const creation = new openbis.SpaceCreation()
      creation.setCode(spaceCode)
      if (description)
        creation.setDescription(description)
      const response = await useOpenBisStore().v3?.createSpaces([creation])
      return response[0] // Assuming the method returns an array of created spaces
    },

    async updateSpace(space: Space): Promise<void> {
      await useOpenBisStore().v3.updateSpaces([space])
    },

    async deleteSpace(spaceId: string, reason: string): Promise<void> { // Assuming spaceId is a string
      const sdo = new openbis.SpaceDeletionOptions().setReason(reason)
      await useOpenBisStore().v3.deleteSpaces([new openbis.SpacePermId(spaceId)], sdo)
    },
  },
})
