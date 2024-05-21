import { defineStore } from 'pinia';
import { ref, reactive } from 'vue';

type ProjectEntity = {
  title: string;
  conditions: Array<any>;
  continous: boolean;
  unit: string | null;
}

export const useProjectEntitiesStore = defineStore('projectEntities', () => {
  const variables = ref<ProjectEntity[]>([
    {
      title: 'genotype',
      conditions: [],
      continous: false,
      unit: null,
    }, 
    {
      title: 'color',
      conditions: [],
      continous: false,
      unit: null,
    },
  ]);

  const addVariable = (variable: ProjectEntity) => {
    variables.value.push(variable);
  };

  const removeVariable = (title: string) => {
    variables.value = variables.value.filter(variable => variable.title !== title);
  };

  return { variables, addVariable, removeVariable };
});
