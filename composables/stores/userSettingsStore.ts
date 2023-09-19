import { defineStore } from 'pinia'

export const useUserSettingsStore = defineStore({
  id: 'userSettings',

  state: () => ({
    selectedSpace: 'DEFAULT',
  }),

  getters: {
    getSelectedSpace() {
      return this.selectedSpace
    },
  },

  actions: {
    setSelectedSpace(space: string) {
      this.selectedSpace = space
    },
  },
})
