import openbis from '../openbis.esm'
import type { Sample } from '../../types/wizard'


/////////////////////    Getter functions    ///////////////////////
export async function listSamplesOfCollection(collectionPermId: string): Promise<openbis.Sample[]> {
  try {
    const openBisStore = useOpenBisStore()
    const criteria = new openbis.SampleSearchCriteria()
    criteria.withExperiment().withPermId().thatEquals(collectionPermId)
    const options = new openbis.SampleFetchOptions()
    const result = await openBisStore.v3?.searchSamples(criteria, options)
    return result?.getObjects() || []
  } catch (error) {
    console.error(`Failed to list samples of collection ${collectionPermId}: ${error}`)
    return []
  }
}

 
export async function getSample(sampleId: string): Promise<openbis.Sample | null> {
  try {
    const openBisStore = useOpenBisStore()
    const result = await openBisStore.v3?.getSamples([new openbis.SamplePermId(sampleId)], new openbis.SampleFetchOptions())
    return result?.[0] || null
  } catch (error) {
    console.error(`Failed to get sample ${sampleId}: ${error}`)
    return null
  }
}


/////////////////////    Sample creation functions    ///////////////////////

export function prepareSampleCreation(sample: Sample, sampleType: string, spaceId: string, projectId: string, experimentId: string) {
  const sampleCreation = new openbis.SampleCreation()
  sampleCreation.setSpaceId(new openbis.SpacePermId(spaceId))
  sampleCreation.setProjectId(new openbis.ProjectPermId(projectId))
  sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType))
  sampleCreation.setExperimentId(new openbis.ExperimentPermId(experimentId))
  sampleCreation.setCode(sample.name)
  if (sample.parents) {
    sampleCreation.setParentIds([new openbis.SamplePermId(sample.parents)])
  }

  // Iterate over conditions and set property for each
  for (const condition of sample.conditions) {
    for (const [key, value] of Object.entries(condition)) {
      sampleCreation.setProperty(key, value)
    }
  }
  return sampleCreation
}


export async function updateSample(sampleUpdate: openbis.SampleUpdate): Promise<boolean> {
  try {
    const openBisStore = useOpenBisStore()
    await openBisStore.v3?.updateSamples([sampleUpdate])
    return true
  } catch (error) {
    console.error(`Failed to update sample: ${error}`)
    return false
  }
}

export async function deleteSample(sampleId: string, reason: string): Promise<boolean> {
  try {
    const openBisStore = useOpenBisStore()
    const deletionOptions = new openbis.SampleDeletionOptions()
    deletionOptions.setReason(reason)
    await openBisStore.v3?.deleteSamples([new openbis.SamplePermId(sampleId)], deletionOptions)
    return true
  } catch (error) {
    console.error(`Failed to delete sample ${sampleId}: ${error}`)
    return false
  }
}

