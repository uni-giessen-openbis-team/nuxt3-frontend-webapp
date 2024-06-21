
import { defineStore } from 'pinia'
import openbis from './openbis.esm'

export const useTypesStore = defineStore('spaces', {
  actions: {
    async getSampleTypes(): Promise<openbis.SampleType[]> {
      const criteria = new openbis.SampleTypeSearchCriteria();
      const fetchOptions = new openbis.SampleTypeFetchOptions();
      fetchOptions.withPropertyAssignments().withPropertyType();
      const types = await useOpenBisStore().v3?.searchSampleTypes(criteria, fetchOptions);
      return types?.getObjects() || [];
    },
    
    async getDataSetTypes(): Promise<openbis.DataSetType[]> {
      const criteria = new openbis.DataSetTypeSearchCriteria();
      const fetchOptions = new openbis.DataSetTypeFetchOptions();
      fetchOptions.withPropertyAssignments().withPropertyType();
      const types = await useOpenBisStore().v3?.searchDataSetTypes(criteria, fetchOptions);
      return types?.getObjects() || [];
    } 
  }
})
