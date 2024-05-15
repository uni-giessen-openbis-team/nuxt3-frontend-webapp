/*
The store is used to fetch, create, update and delete spaces.
Spaces are used to group projects and experiments.
*/

import { defineStore } from 'pinia'
import openbis from './openbis.esm'

export const useSpaceStore = defineStore('spaces', {
  state: () => ({
    // Initialize spaces as an empty array.
    // Using ref here is optional since Pinia manages reactivity,
    // but included to align with your usage of async functions and external modules.
    spaces: ref([]),
  }),
  actions: {
    async getAllSpaces(): Promise<Space[]> {
      const criteria = new openbis.SpaceSearchCriteria()
      const fo = new openbis.SpaceFetchOptions()
      const result = await useOpenBisStore().v3.searchSpaces(criteria, fo)
      return result.objects
    },

    async getSpace(spaceId: string, options = {}): Promise<Space | null> {
      const openBisStore = useOpenBisStore()
      if (!openBisStore)
        return null
      const result = await openBisStore().v3.getSpaces(
        new openbis.SpacePermId(spaceId),
        new openbis.SpaceFetchOptions(options),
      )
      return result.get(spaceId)
    },

    async createSpace(spaceCode: string, description: string | null = null): Promise<Space | undefined> {
      const creation = new openbis.SpaceCreation()
      creation.setCode(spaceCode)
      if (description)
        creation.setDescription(description)
      const response = await useOpenBisStore().v3.createSpaces([creation])
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
