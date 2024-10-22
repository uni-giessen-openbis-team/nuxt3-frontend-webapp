import type { Sample } from "@/types/wizard";


export function countToSingleSamples(samples: Sample[]): Sample[] {
    const newSamples: Sample[] = [];
    
    samples.forEach(sample => {
      if (sample.count >= 2) {
        for (let i = 0; i < sample.count; i++) {
          newSamples.push({
            ...sample,
            name: `${sample.name}_${i + 1}`,
            count: 1 // Each split sample has a count of 1
          });
        }
      } else {
        newSamples.push(sample);
      }
    });
  
    return newSamples;
  }
  
  // Example usage
  const samples: Sample[] = [
    { conditions: [], externalDBID: '1', name: 'sampleA', count: 1, sampleType: 'type1' },
    { conditions: [], externalDBID: '2', name: 'sampleB', count: 3, sampleType: 'type2' },
    { conditions: [], externalDBID: '3', name: 'sampleC', count: 2, sampleType: 'type3' }
  ];
  
  const separatedSamples = countToSingleSamples(samples);
  console.log(separatedSamples);