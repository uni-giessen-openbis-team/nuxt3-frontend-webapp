import type { Property, Sample } from '@/types/wizard'

function cartesianProduct<T>(arrays: T[][]): T[][] {
  return arrays.reduce((a, b) => a.flatMap(d => b.map(e => [...d, e])), [[]] as T[][]);
  
}


export function calculateSamplesFromProperties(properties: Property[]): Sample[] {
    const crossProduct: Sample[] = [];
     
    const conditionsArrays = properties.map(property => property.conditions || []);
    console.log(conditionsArrays) // []
    const product = cartesianProduct(conditionsArrays);
    product.forEach((conditionSet) => {
      const newSample: Partial<Sample> = {
        conditions: conditionSet.map((condition, conditionIndex) => ({
          propertyTitle: properties[conditionIndex]?.title || '', // Provide a default empty string
          conditionTerm: condition.title
        })),  
        externalDBID: conditionSet.map(condition => condition.title).join('_'),
        secondaryName: conditionSet.map(condition => condition.title).join('_'),
        count: 1
      };
      crossProduct.push(newSample as Sample);
    });
  
    return crossProduct;
  }
  
