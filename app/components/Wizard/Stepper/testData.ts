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
    conditions: []
}

export const samples:Sample[] = [
    {
        sampleType: 'Sample Type 1',
        externalDBID: '1',
        secondaryName: 'Sample 1',
        count: 1,
        conditions: [
            {
                propertyTitle: 'Property 1',
                conditionTerm : 'Condition 2'
            }
        ]
    }
]