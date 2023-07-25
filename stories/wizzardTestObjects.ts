export const entetyCombinations = [
  {
    conditions: [
      { species: 'Mouse' },
      { genotype: 'gen1' },
    ],
    externalDBID: '',
    secondaryName: 'Mouse ; gen1',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_ENTITY',
  },
  {
    conditions: [
      { species: 'Mouse' },
      { genotype: 'gen2' },
    ],
    externalDBID: '',
    secondaryName: 'Mouse ; gen2',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_ENTITY',
  },
]

export const combinedEntetyAndSample = [
  {
    conditions: [
      {
        tissue: 'tissue1',
      },
      {
        species: 'Mouse',
      },
    ],
    externalDBID: '',
    secondaryName: 'tissue1 ; tissue1',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_SAMPLE',
    child: 'Mouse',
  },
  {
    conditions: [
      {
        tissue: 'tissue2',
      },
      {
        species: 'Mouse',
      },
    ],
    externalDBID: '',
    secondaryName: 'tissue2 ; tissue2',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_SAMPLE',
    child: 'Mouse',
  },
  {
    conditions: [
      {
        tissue: 'tissue1',
      },
      {
        species: 'Hunman',
      },
    ],
    externalDBID: '',
    secondaryName: 'tissue1 ; tissue1',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_SAMPLE',
    child: 'Hunman',
  },
  {
    conditions: [
      {
        tissue: 'tissue2',
      },
      {
        species: 'Hunman',
      },
    ],
    externalDBID: '',
    secondaryName: 'tissue2 ; tissue2',
    count: '1',
    sampleType: 'Q_BIOLOGICAL_SAMPLE',
    child: 'Hunman',
  },
]
