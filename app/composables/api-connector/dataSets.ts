import openbis from '../openbis.esm'

async function prepareDatasetCreation(sample: openbis.Sample, projectContext: ProjectContext): Promise<openbis.DataSetCreation> {
  const dataSetCreation = new openbis.DataSetCreation();
  dataSetCreation.setCode("newCode");
  dataSetCreation.setSampleId(new openbis.SamplePermId(sample.secondaryName));
  dataSetCreation.setTypeId(new openbis.EntityTypePermId("ANALYZED_DATA"));
  return dataSetCreation;
}

async function createDataset(datasetCreation: openbis.DataSetCreation): Promise<openbis.DataSetPermId[]> {
  const openBisStore = useOpenBisStore()
  return await openBisStore.v3?.createDataSets([datasetCreation]) || [];
}

async function listDataSets(criteria = new openbis.DataSetSearchCriteria(), options = fetchDataSetCompletely()): Promise<openbis.DataSet[]> {
  try {
    const openBisStore = useOpenBisStore()
    console.log('Fetching datasets with criteria:', criteria, 'and options:', options)
    const result = await openBisStore.v3?.searchDataSets(criteria, options)
    console.log('Result from searchDataSets:', result)
    return result?.getObjects() ?? []
  } catch (error ) {
    if (error instanceof Error) {
      console.error(`${error.name}: ${error.message}`)
    } else {
      console.error('An unknown error occurred')
    }
    console.warn(`listDataSets failed with criteria ${criteria} and options ${options}, returned an empty list.`)
    return []
  }
}

async function listAllDataSets(): Promise<openbis.DataSet[]> {
  console.log('Calling listAllDataSets')
  return listDataSets()
}

async function listDataSetsOfType(typeId: string): Promise<openbis.DataSet[]> {
  const criteria = new openbis.DataSetSearchCriteria()
  criteria.withType().withId().thatEquals(typeId)
  return listDataSets(criteria)
}

async function listDataSetsOfSpace(spaceCode: string): Promise<openbis.DataSet[]> {
  const criteria = new openbis.DataSetSearchCriteria()
  criteria.withOrOperator()
  criteria.withSample().withSpace().withCode().thatEquals(spaceCode)
  criteria.withExperiment().withProject().withSpace().withCode().thatEquals(spaceCode)
  return listDataSets(criteria)
}

async function listDataSetsOfProject(projectId: string): Promise<openbis.DataSet[]> {
  const criteria = new openbis.DataSetSearchCriteria()
  criteria.withOrOperator()
  criteria.withSample().withProject().withId().thatEquals(projectId)
  criteria.withExperiment().withProject().withId().thatEquals(projectId)
  return listDataSets(criteria)
}

async function listDataSetsOfCollection(collectionId: number): Promise<openbis.DataSet[]> {
  const criteria = new openbis.DataSetSearchCriteria()
  criteria.withExperiment().withId().thatEquals(collectionId)
  return listDataSets(criteria)
}

async function listDataSetsOfObject(objectPermId: string): Promise<openbis.DataSet[]> {
  const criteria = new openbis.DataSetSearchCriteria()
  criteria.withSample().withPermId().thatEquals(objectPermId)
  return listDataSets(criteria)
}

async function getDataSet(datasetId: string, options = fetchDataSetCompletely()): Promise<openbis.DataSet | null> {
  try {
    const openBisStore = useOpenBisStore()
    console.log('Fetching dataset with ID:', datasetId)
    const result = await openBisStore.v3?.getDataSets([new openbis.DataSetPermId(datasetId)], options)
    console.log('Result from getDataSets:', result);
    return result ? result[0] : null;
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`);
    console.warn(`getDataSet failed with datasetId ${datasetId} and options ${options}, returned null.`);
    return null;
  }
}

async function getDataSets(datasetIds: string[]): Promise<openbis.DataSet[]> {
  try {
    const openBisStore = useOpenBisStore()
    console.log('Fetching datasets with IDs:', datasetIds)
    const result = await openBisStore.v3?.getDataSets(datasetIds.map(id => new openbis.DataSetPermId(id)), fetchDataSetCompletely())
    console.log('Result from getDataSets:', result)
    return result?.objects ?? []
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`getDataSets failed with datasetIds ${datasetIds}, returned an empty list.`)
    return []
  }
}

async function updateDataSet(datasetUpdate: openbis.DataSetUpdate): Promise<boolean> {
  try {
    const openBisStore = useOpenBisStore()
    console.log('Updating dataset with update:', datasetUpdate)
    await openBisStore.v3?.updateDataSets([datasetUpdate])
    return true
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`updateDataSet failed with datasetUpdate ${datasetUpdate}, returned false.`)
    return false
  }
}

async function deleteDataSet(datasetId: string, reason: string): Promise<boolean> {
  try {
    const openBisStore = useOpenBisStore()
    const options = new openbis.DataSetDeletionOptions()
    options.setReason(reason)
    console.log('Deleting dataset with ID:', datasetId, 'and reason:', reason)
    await openBisStore.v3?.deleteDataSets([new openbis.DataSetPermId(datasetId)], options)
    return true
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`deleteDataSet failed with datasetId ${datasetId} and reason ${reason}, returned false.`)
    return false
  }
}

async function deleteDataSets(datasetIds: string[], reason: string): Promise<boolean> {
  try {
    const openBisStore = useOpenBisStore()
    const options = new openbis.DataSetDeletionOptions()
    options.setReason(reason)
    console.log('Deleting datasets with IDs:', datasetIds, 'and reason:', reason)
    await openBisStore.v3?.deleteDataSets(datasetIds.map(id => new openbis.DataSetPermId(id)), options)
    return true
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`deleteDataSets failed with datasetIds ${datasetIds} and reason ${reason}, returned false.`)
    return false
  }
}

async function deleteDataSetPermanently(datasetId: string, reason: string): Promise<boolean> {
  try {
    const deletionId = await deleteDataSet(datasetId, reason)
    if (deletionId) {
      const openBisStore = useOpenBisStore()
      console.log('Confirming deletion with ID:', deletionId)
      await openBisStore.v3?.confirmDeletions([deletionId])
      return true
    }
    return false
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`deleteDataSetPermanently failed with datasetId ${datasetId} and reason ${reason}, returned false.`)
    return false
  }
}

async function getDataSetStream(datasetId: string): Promise<ReadableStream | null> {
  try {
    const openBisStore = useOpenBisStore()
    const fileId = new openbis.DataSetFilePermId(datasetId)
    const options = new openbis.DataSetFileDownloadOptions()
    options.setRecursive(true)
    console.log('Fetching data stream for dataset with ID:', datasetId)
    return await openBisStore.dss3?.downloadFiles([fileId], options) || null
  } catch (error: any) {
    console.error(`${error.name}: ${error.message}`)
    console.warn(`getDataSetStream failed with datasetId ${datasetId}, returned null.`)
    return null
  }
}

export {
  prepareDatasetCreation,
  createDataset,
  listDataSets,
  listAllDataSets,
  listDataSetsOfType,
  listDataSetsOfSpace,
  listDataSetsOfProject,
  listDataSetsOfCollection,
  listDataSetsOfObject,
  getDataSet,
  getDataSets,
  updateDataSet,
  deleteDataSet,
  deleteDataSets,
  deleteDataSetPermanently,
  getDataSetStream
}
