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
          { propertyTitle: 'Condition 1', conditionTerm: 'Condition 1' },
          { propertyTitle: 'Condition A', conditionTerm: 'Condition A' }
        ],
        secondaryName: '',
        count: 1
      },
      {
        conditions: [
          { propertyTitle: 'Condition 1', conditionTerm: 'Condition 1' },
          { propertyTitle: 'Condition B', conditionTerm: 'Condition B' }
        ],
        secondaryName: '',
        count: 1
      },
      {
        conditions: [
          { propertyTitle: 'Condition 2', conditionTerm: 'Condition 2' },
          { propertyTitle: 'Condition A', conditionTerm: 'Condition A' }
        ],
        secondaryName: '',
        count: 1
      },
      {
        conditions: [
          { propertyTitle: 'Condition 2', conditionTerm: 'Condition 2' },
          { propertyTitle: 'Condition B', conditionTerm: 'Condition B' }
        ],
        secondaryName: '',
        count: 1
      }
    ];

    const result = calculateSamplesFromProperties(properties);
    expect(result).toEqual(expectedSamples);
  });
});