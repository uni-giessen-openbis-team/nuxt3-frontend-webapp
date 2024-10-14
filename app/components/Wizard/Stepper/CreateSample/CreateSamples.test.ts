// @vitest-environment nuxt
import {  expect, it } from 'vitest'
import CreateSamples from './CreateSamples.vue' 
import { renderSuspended } from '@nuxt/test-utils/runtime'
import type { Property, Sample } from '@/types/wizard'

it('can render some component', async () => {
    await renderSuspended(CreateSamples)
    const { calculateSamplesFromProperties } = CreateSamples.methods as typeof CreateSamples
    const result = calculateSamplesFromProperties([{conditions: [{label: 'test'}]}]);
    expect(result).toEqual([{conditions: [{label: 'test'}], secondaryName: '', count: '1'}]);
  })

it('calculates samples from properties correctly', async () => {
    const { calculateSamplesFromProperties } = CreateSamples.methods as typeof CreateSamples;

    // Define fake properties for testing
    const fakeProperties: Property[] = [
        {
            title: 'Property 1',
            conditions: [
                { title: 'Condition 1' },
                { title: 'Condition 2' }
            ],
        } as Property,
        {
            title: 'Property 2',
            conditions: [
                { title: 'Condition 3' }
            ],
            continuous: true,
            unit: 'mg'
        } as Property
    ];

    // Define the expected result based on the fake properties
    const expectedSamples: Sample[] = [
        {
            conditions: [
                { propertyTitle: 'Property 1', conditionTitle: 'Condition 1' },
                { propertyTitle: 'Property 2', conditionTitle: 'Condition 3' }
            ],
            externalDBID: '',
            secondaryName: 'Condition_1_Condition_2',
            count: '1',
            sampleType: '',
            parent: undefined
        },
        {
            conditions: [
                { propertyTitle: 'Property 1', conditionTitle: 'Condition 1' },
                { propertyTitle: 'Property 2', conditionTitle: 'Condition 3' }
            ],
            externalDBID: '',
            secondaryName: '',
            count: '1',
            sampleType: '',
            parent: undefined
        }
    ];

    // Call the function and assert the result
    const result = calculateSamplesFromProperties(fakeProperties);
    expect(result).toEqual(expectedSamples);
});
