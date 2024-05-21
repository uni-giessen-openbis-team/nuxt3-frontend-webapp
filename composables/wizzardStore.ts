import { defineStore } from 'pinia';

type ProjectEntity = {
  title: string;
  conditions: Array<any>;
  continuous: boolean;
  unit: string | null;
}

export interface ProjectContext {
  UUID: string;
  space: string | null;
  name: string | null;
  contactPerson: string | null;
  manager: string | null;
  description: string | null;
}

export const useWizzardStore = defineStore('wizzardStore', {
  state: () => ({
    variables: [
      { 
        title: 'genotype',
        conditions: [],
        continuous: false,
        unit: null,
      },
      {
        title: 'color',
        conditions: [],
        continuous: false,
        unit: null,
      },
    ] as ProjectEntity[],
  }),
  
  actions: {
    addVariable(variable: ProjectEntity) {
      this.variables.push(variable);
    },
    removeVariable(title: string) {
      this.variables = this.variables.filter(variable => variable.title !== title);
    },
  }
});
