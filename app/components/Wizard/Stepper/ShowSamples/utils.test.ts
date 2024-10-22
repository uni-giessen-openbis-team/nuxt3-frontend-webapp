// wizard.test.ts
import { describe, it, expect } from 'vitest';
import type { Sample } from '@/types/wizard';
import { countToSingleSamples } from './utils';

describe('countToSingleSamples', () => {
  it('should return the same sample if count is 1', () => {
    const samples: Sample[] = [
      { conditions: [], externalDBID: '1', name: 'sampleA', count: 1, sampleType: 'type1' }
    ];
    const result = countToSingleSamples(samples);
    expect(result).toEqual(samples);
  });

  it('should split samples with count greater than 1', () => {
    const samples: Sample[] = [
      { conditions: [], externalDBID: '2', name: 'sampleB', count: 3, sampleType: 'type2' }
    ];
    const expected: Sample[] = [
      { conditions: [], externalDBID: '2', name: 'sampleB_1', count: 1, sampleType: 'type2' },
      { conditions: [], externalDBID: '2', name: 'sampleB_2', count: 1, sampleType: 'type2' },
      { conditions: [], externalDBID: '2', name: 'sampleB_3', count: 1, sampleType: 'type2' }
    ];
    const result = countToSingleSamples(samples);
    expect(result).toEqual(expected);
  });

  it('should handle a mix of samples with different counts', () => {
    const samples: Sample[] = [
      { conditions: [], externalDBID: '1', name: 'sampleA', count: 1, sampleType: 'type1' },
      { conditions: [], externalDBID: '2', name: 'sampleB', count: 2, sampleType: 'type2' }
    ];
    const expected: Sample[] = [
      { conditions: [], externalDBID: '1', name: 'sampleA', count: 1, sampleType: 'type1' },
      { conditions: [], externalDBID: '2', name: 'sampleB_1', count: 1, sampleType: 'type2' },
      { conditions: [], externalDBID: '2', name: 'sampleB_2', count: 1, sampleType: 'type2' }
    ];
    const result = countToSingleSamples(samples);
    expect(result).toEqual(expected);
  });
});