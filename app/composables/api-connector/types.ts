
import openbis from '../openbis.esm'

async function getSampleTypes(): Promise<openbis.SampleType[]> {
  const criteria = new openbis.SampleTypeSearchCriteria();
  const fetchOptions = new openbis.SampleTypeFetchOptions();
  fetchOptions.withPropertyAssignments().withPropertyType();
  const types = await useOpenBisStore().v3?.searchSampleTypes(criteria, fetchOptions);
  return types?.getObjects() || [];
}

async function getDataSetTypes(): Promise<openbis.DataSetType[]> {
  const criteria = new openbis.DataSetTypeSearchCriteria();
  const fetchOptions = new openbis.DataSetTypeFetchOptions();
  fetchOptions.withPropertyAssignments().withPropertyType();
  const types = await useOpenBisStore().v3?.searchDataSetTypes(criteria, fetchOptions);
  return types?.getObjects() || [];
}

export {
  getSampleTypes,
  getDataSetTypes
}
