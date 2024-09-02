import openbis from '../openbis.esm'

async function listSamplesOfCollection(collectionPermId: string): Promise<openbis.Sample[]> {
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

function createSample(sample, projectContext, sampleCreationsDict) {
  const sampleCreation = new openbis.SampleCreation()
  sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType))
  sampleCreation.setSpaceId(new openbis.SpacePermId(projectContext.space))

  // Iterate over conditions and set property for each
  for (const condition of sample.conditions) {
    for (const [key, value] of Object.entries(condition)) {
      sampleCreation.setProperty(key, value)
    }
  }

  if (sample.parent) {
    const parentSampleCreation = sampleCreationsDict[sample.parent]
    if (parentSampleCreation) {
      sampleCreation.setParentIds([parentSampleCreation.getCreationId()])

      const parentChildIds = parentSampleCreation.getChildIds() || []
      parentChildIds.push(sampleCreation.getCreationId())
      parentSampleCreation.setChildIds(parentChildIds)
    } else {
      console.log('Parent sample not found')
    }
  }

  return sampleCreation
}

async function createSamples(samples, projectContext) {
  const openBisStore = useOpenBisStore()
  const sampleCreations = []
  const sampleCreationsDict = {}

  for (const sample of samples) {
    const sampleCreation = createSample(sample, projectContext, sampleCreationsDict)
    sampleCreations.push(sampleCreation)
    sampleCreationsDict[sample.id] = sampleCreation
  }

  try {
    const result = await openBisStore.v3?.createSamples(sampleCreations)
    return result || []
  } catch (error) {
    console.error('Failed to create samples:', error)
    return []
  }
}

async function getSample(sampleId: string): Promise<openbis.Sample | null> {
  try {
    const openBisStore = useOpenBisStore()
    const result = await openBisStore.v3?.getSamples([new openbis.SamplePermId(sampleId)])
    return result?.[0] || null
  } catch (error) {
    console.error(`Failed to get sample ${sampleId}: ${error}`)
    return null
  }
}

async function updateSample(sampleUpdate: openbis.SampleUpdate): Promise<boolean> {
  try {
    const openBisStore = useOpenBisStore()
    await openBisStore.v3?.updateSamples([sampleUpdate])
    return true
  } catch (error) {
    console.error(`Failed to update sample: ${error}`)
    return false
  }
}

async function deleteSample(sampleId: string, reason: string): Promise<boolean> {
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

export {
  listSamplesOfCollection,
  createSample,
  createSamples,
  getSample,
  updateSample,
  deleteSample
}