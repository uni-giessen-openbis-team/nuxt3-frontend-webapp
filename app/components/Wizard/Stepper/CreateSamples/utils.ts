import type { Property, Sample } from '@/types/wizard'
import { v4 as uuidv4 } from 'uuid';

function cartesianProduct<T>(arrays: T[][]): T[][] {
  return arrays.reduce((a, b) => a.flatMap(d => b.map(e => [...d, e])), [[]] as T[][]);
  
}


export function calculateSamplesFromProperties(properties: Property[]): Sample[] {
    const crossProduct: Sample[] = [];
     
    const conditionsArrays = properties.map(property => property.conditions || []);
    console.log(conditionsArrays) // []
    const product = cartesianProduct(conditionsArrays);
    product.forEach((conditionSet) => {
      const newSample: Sample = {
        id: uuidv4(),
        conditions: conditionSet.map((condition, conditionIndex) => ({
          propertyTitle: properties[conditionIndex]?.title || '', // Provide a default empty string
          conditionTerm: condition.title
        })),  
        externalDBID: conditionSet.map(condition => condition.title).join('_'),
        name: conditionSet.map(condition => condition.title).join('_'),
        count: 1,
        parents: [],
        pools: [],
      };
      crossProduct.push(newSample as Sample);
    });
  
    return crossProduct;
  }
  

  export function createPoolSamples(samples: Sample[]): Sample[] {
    const poolMap: Map<string, Sample> = new Map();
    
    samples.forEach(sample => {
      sample.pools?.forEach(pool => {
        if (!poolMap.has(pool)) {
          // Create a new sample for the new pool
          const newSample: Sample = {
            id: sample.id,
            conditions: [{ propertyTitle: pool, conditionTerm: pool }],
            externalDBID: pool,
            name: pool,
            count: 1,
            pools: [pool],
            parents: [sample.externalDBID]
          };
          poolMap.set(pool, newSample);
        } else {
          // Add the current sample as a parent to the existing pool sample
          const existingSample = poolMap.get(pool);
          existingSample?.parents?.push(sample.externalDBID);
        }
      });
    });
  
    return Array.from(poolMap.values());
  }
  