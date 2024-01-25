export interface SpaceTechId {
  techId: number
  '@type': 'as.dto.space.id.SpaceTechId'
  id: string
}

export interface SpacePermId {
  permId: string
  '@type': 'as.dto.space.id.SpacePermId'
}

export interface SpaceFetchOptions {
  '@type': 'as.dto.space.fetchoptions.SpaceFetchOptions'
  count?: number
  from?: number
  cacheMode: string
  registrator?: any
  samples?: any
  projects?: any
  sort?: any
  sortBy?: any
}

export interface Space {
  '@type': 'as.dto.space.Space'
  fetchOptions: SpaceFetchOptions
  id: SpaceTechId
  permId: SpacePermId
  code: string
  description?: string
  frozen: boolean
  frozenForProjects: boolean
  frozenForSamples: boolean
  registrationDate: number
  modificationDate: number
  registrator?: any
  samples?: any
  projects?: any
}
