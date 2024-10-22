import { describe, it, expect } from 'vitest';
import { calculateSamplesFromProperties } from './utils';
import type { Property } from '@/types/wizard';

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
      {
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 1' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition A' }
        ],
        secondaryName: 'Condition 1_Condition A',
        count: 1,
        externalDBID: 'Condition 1_Condition A'
      },
      {
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 1' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition B' }
        ],
        secondaryName: 'Condition 1_Condition B',
        count: 1,
        externalDBID: 'Condition 1_Condition B'
      },
      {
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 2' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition A' }
        ],
        secondaryName: 'Condition 2_Condition A',
        count: 1,
        externalDBID: 'Condition 2_Condition A'
      },
      {
        conditions: [
          { propertyTitle: 'Property 1', conditionTerm: 'Condition 2' },
          { propertyTitle: 'Property 2', conditionTerm: 'Condition B' }
        ],
        secondaryName: 'Condition 2_Condition B',
        count: 1,
        externalDBID: 'Condition 2_Condition B'
      }
    ];

    const result = calculateSamplesFromProperties(properties);
    expect(result).toEqual(expectedSamples);
  });
});
