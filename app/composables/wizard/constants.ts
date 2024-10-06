
import type { Entity, ProjectContext, TableVariable, combinedVariable } from '@/types/wizard';

 
// The variables that are available for the entety variables in the wizard

export const entetySampleItems: Entity[] = [
  {
    title: 'genotype',
    conditions: [],
    vocabularyCode: "",
  },
]

// The variables that are available for the biological sample variables in the wizard

export const biologicalSampletems: Entity[] = [
  {
    title: 'genotype',
    conditions: [],
    vocabularyCode: "",
  },
  {
    title: 'color',
    conditions: [],
    continuous: false, 
    unit: null,
  },
] 

// The variables that are available for the technical sample variables in the wizard

export const technicalSampletems: Entity[] = [
    {
      title: 'Method',
      conditions: [],
      continuous: false,
      unit: null,
      vocabularyCode: null,
    },
  ]


   