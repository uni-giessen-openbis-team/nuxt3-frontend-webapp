// Define the types for properties which are used in the wizard to select 

import type { Property } from "~/types/wizard"

export const entityVariables: (Property)[] = [
  {
    title: 'genotype',
    vocabularyCode: "TEST",
    continuous: false,
  },
  {
    title: 'color',
    continuous: false, 
    unit: null,
  },
] as Property[]

export const biologicalSampleVariables: Array< Property> = [
  {
    title: 'species',
    vocabularyCode: "TEST",
  },
] as Property[]

export const sampleVariables: Array< Property> = [
  {
    title: 'tissue',
    continuous: false,
    unit: null,
  },
] as Property[]