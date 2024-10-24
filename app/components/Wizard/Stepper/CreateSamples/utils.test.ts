import { describe, it, expect } from 'vitest';
import { calculateSamplesFromProperties, createPoolSamples } from './utils';
import { createSample } from '@/tests/utils';
import type { Property, Sample } from '@/types/wizard';


describe('calculateSamplesFromProperties', () => {
  it('should calculate samples correctly from properties', () => {
    const properties: Property[] = [
      {
        title: 'Property 1',
        description: 'Description 1',
        continuous: false,
        unit: '',
        conditions: [
          { title: 'Condition 1', description: 'Description 1' },
          { title: 'Condition 2', description: 'Description 2' }
        ]
      },
      { 
        title: 'Property 2',
        description: 'Description 2',
        continuous: false,
        unit: '',
        conditions: [
          { title: 'Condition A', description: 'Description A' },
          { title: 'Condition B', description: 'Description B' }
        ]
      }
    ];

    const expectedSamples = [
      createSample({
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 1' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition A' }
        ],
        name: 'Condition 1_Condition A',
        externalDBID: 'Condition 1_Condition A'
      }),
      createSample({
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 1' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition B' }
        ],
        name: 'Condition 1_Condition B',
        externalDBID: 'Condition 1_Condition B'
      }),
      createSample({
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 2' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition A' }
        ],
        name: 'Condition 2_Condition A',
        externalDBID: 'Condition 2_Condition A'
      }),
      createSample({
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 2' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition B' }
        ],
        name: 'Condition 2_Condition B',
        externalDBID: 'Condition 2_Condition B'
      })
    ];

    const result = calculateSamplesFromProperties(properties);
    expect(result).toEqual(expectedSamples);
  });
});



describe('createPoolSamples', () => {
  it('should return an empty array when given an empty array', () => {
    const samples: Sample[] = [];
    const result = createPoolSamples(samples);
    expect(result).toEqual([]);
  });

  it('should process samples with pools correctly', () => {
    const samples: Sample[] = [
      createSample({
        id: '1',
        externalDBID: 'sample1',
        name: 'Sample 1',
        pools: ['pool1', 'pool2']
      }),
      createSample({
        id: '2',
        externalDBID: 'sample2',
        name: 'Sample 2',
        pools: ['pool2', 'pool3']
      })
    ];

    const expected = [
      createSample({
        id: '1',
        conditions: [{ propertyTitle: 'pool1', conditionTerm: 'pool1' }],
        externalDBID: 'pool1',
        name: 'pool1',
        pools: ['pool1'],
        parents: ['sample1']
      }),
      createSample({
        id: '1',
        conditions: [{ propertyTitle: 'pool2', conditionTerm: 'pool2' }],
        externalDBID: 'pool2',
        name: 'pool2',
        pools: ['pool2'],
        parents: ['sample1', 'sample2']
      }),
      createSample({
        id: '2',
        conditions: [{ propertyTitle: 'pool3', conditionTerm: 'pool3' }],
        externalDBID: 'pool3',
        name: 'pool3',
        pools: ['pool3'],
        parents: ['sample2']
      })
    ];

    const result = createPoolSamples(samples);
    expect(result).toEqual(expected);
  });

  it('should handle samples with no pools', () => {
    const samples: Sample[] = [
      createSample({
        id: '1',
        externalDBID: 'sample1',
        name: 'Sample 1'
      })
    ];

    const result = createPoolSamples(samples);
    expect(result).toEqual([]);
  });
});
