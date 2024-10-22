import type { PropertyWithVocabulary, PropertyWithoutVocabulary,Sample } from "@/types/wizard"



export const propertyWithVocabulary: PropertyWithVocabulary = {
    title: 'Property 2', description: 'Description 2',
    vocabulary:
    {
        title: 'Vocabulary 1',
        code: 'TEST',
        terms: [{ title: 'Term 1', description: 'Description 1' }]
    },
    conditions: []
} 


export const propertyWithoutVocabulary: PropertyWithoutVocabulary =
{
    title: 'Property 1',
    description: 'Description 1',
    continuous: false,
    unit: null,
    conditions: [],
    category: 'YourCategoryValue'
}

export const samples:Sample[] = [
    {
        externalDBID: '1',
        name: 'Sample 1',
        count: 1,
        conditions: [
            {
                propertyTitle: 'Property 1',
                conditionTerm : 'Condition 2'
            }
        ]
    }
]
 


export const biologicalEntity = {
    taxonomyClassification: [
      { title: "Species" },
    ],
    morphologyStructure: [
      { title: "Anatomy" },
      { title: "Physiology" },
      { title: "Phenotype" },
      { title: "Body Plan" }
    ],
    behaviorEcology: [
      { title: "Habitat" },
      { title: "Niche" },
      { title: "Behavior" },
      { title: "Diet" },
      { title: "Symbiosis" }
    ],
    geneticsEvolution: [
      { title: "Genome" },
      { title: "Mutation" },
      { title: "Adaptation" },
      { title: "Lineage" }
    ],
    reproductionLifeCycle: [
      { title: "Reproductive Strategy" },
      { title: "Life Stages" },
      { title: "Gestation/Incubation Period" }
    ],
    geographyDistribution: [
      { title: "Range" },
      { title: "Endemic" },
      { title: "Invasive" }
    ],
    conservationStatus: [
      { title: "Conservation Status" },
      { title: "Population Trends" },
      { title: "Threats" }
    ],
    physiologicalAdaptations: [
      { title: "Thermoregulation" },
      { title: "Metabolism" },
      { title: "Respiration" }
    ],
    symbioticRelationships: [
      { title: "Host" },
      { title: "Commensalism" }
    ],
    ethology: [
      { title: "Foraging" },
      { title: "Social Structure" },
      { title: "Communication" }
    ]
  };


 export  const biologicalSamples = {
    sampleTypes: [
      { title: "Tissue Sample" },
      { title: "DNA Extract" },
      { title: "RNA Extract" },
      { title: "Plasma Sample" },
      { title: "Serum Sample" }
    ],
    sourceInformation: [
      { title: "Source Organism" },
      { title: "Tissue/Organ Source" },
      { title: "Collection Method" },
      { title: "Collection Date" }
    ],
    preservationDetails: [
      { title: "Preservation Method" },
      { title: "Storage Temperature" },
      { title: "Storage Duration" }
    ],
    extractionInformation: [
      { title: "Extraction Method" },
      { title: "Concentration" },
      { title: "Purity (A260/A280)" },
      { title: "Purity (A260/A230)" },
      { title: "RNA Integrity Number (RIN)" }
    ],
    
  };


export const technicalSample = {
    sampleMetadata: [
      { title: "Sample ID" },
      { title: "Sample Type" },
      { title: "Source Organism" },
      { title: "Collection Date" }
    ],
    sequencingDetails: [
      { title: "Sequencing Method" },
      { title: "Sequencing Platform" },
      { title: "Read Length" },
      { title: "Coverage Depth" }
    ],
    sequencingParameters: [
        { title: "Read Length" },
        { title: "Paired-End or Single-End" },
        { title: "Coverage Depth" },
        { title: "Yield" },
        { title: "Error Rate" }
      ],
    analysisDetails: [
      { title: "Assembly Method" },
      { title: "Alignment Tool" },
      { title: "Variant Calling Method" },
      { title: "Annotation Method" }
    ],
  };

