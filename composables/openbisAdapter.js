// Wrap the RequireJS call in a Promise
const loadDependencies = new Promise((resolve, reject) => {
  require(
    [
      'openbis',
      'as/dto/space/search/SpaceSearchCriteria',
      'as/dto/space/fetchoptions/SpaceFetchOptions',
    ],
    (Openbis, SpaceSearchCriteria, SpaceFetchOptions) => {
      resolve({ Openbis, SpaceSearchCriteria, SpaceFetchOptions })
    },
    (err) => {
      reject(err)
    },
  )
})

// Wrap the openbis API in an ES6 compatible module
export default {
  login: async (username, password) => {
    const { Openbis } = await loadDependencies
    const v3 = new Openbis()
    await v3.login(username, password)
    return v3
  },

  searchSpaces: async (v3) => {
    const { SpaceSearchCriteria, SpaceFetchOptions } = await loadDependencies
    const searchCriteria = new SpaceSearchCriteria()
    const fetchOptions = new SpaceFetchOptions()
    const result = await v3.searchSpaces(searchCriteria, fetchOptions)
    return result.getObjects()
  },

  logout: async (v3) => {
    await v3.logout()
  },
}
