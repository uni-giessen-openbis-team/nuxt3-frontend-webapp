// Define the types for properties which are used in the wizard to select 

export const entityVariables: (PropertyWithoutVocabulary | PropertyWithVocabulary)[] = [
  {
    title: 'genotype',
    vocabularyCode: "Q_NCBI_TAXONOMY",
    continuous: false,
  },
  {
    title: 'color',
    continuous: false, 
    unit: null,
  },
]

export const biologicalSampleVariables: Array< PropertyWithoutVocabulary | PropertyWithVocabulary> = [
  {
    title: 'species',
    vocabularyCode: "Q_NCBI_TAXONOMY",
  },
]

export const sampleVariables: Array< PropertyWithoutVocabulary | PropertyWithVocabulary> = [
  {
    title: 'tissue',
    continuous: false,
    unit: null,
  },
]