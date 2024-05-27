import { defineStore } from 'pinia';
import type { ProjectEntity, ProjectContext, TableVariable, combinedVariable } from '@/types/wizzard';
import openbis from './openbis.esm';
 
/* 
Variables are the building blocks of the wizzard. They are used to define the
conditions that will be used to create the samples. The cross product of the
variables will be used to create the samples.  
*/

 type Sample = {
  conditions: { [key: string]: string }[];
  externalDBID: string;
  secondaryName: string;
  count: string;
  sampleType: string;
};

export const useWizzardStore = defineStore('wizzardStore', {
  state: () => ({
    selectedVariables: [] as ProjectEntity[],
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
    projectContext: {
      UUID: '',
      space: null,
      name: null,
      contactPerson: null,
      manager: null,
      description: null,
    } as ProjectContext,
    entetyVariables: [
      { 
        title: 'species',
        conditions: [""],
        continuous: false,
        unit: null,
      },
    ] as ProjectEntity[],
    entetyConditionsResult: [] as Sample[],
    sampleVariables: [
      { 
        title: 'tissue',
        conditions: [],
        continuous: false,
        unit: null,
      },
    ] as ProjectEntity[],
    sampleConditionsResult: [] as Sample[],
    entetyAndSampleResult: [] as Sample[],
    techVariables: [
      { 
        title: 'methods',
        conditions: [],
        continuous: false,
        unit: null,
      },
    ] as ProjectEntity[],
    techConditionsResult: [] as Sample[],
    result: [] as Sample[],
    tmpResult: [] as string[],
  }),

  actions: {
    addVariable(variable: ProjectEntity) {
      this.variables.push(variable);
    },
    removeVariable(title: string) {
      this.variables = this.variables.filter(variable => variable.title !== title);
    },
    updateEntety() {
      const SAMPLE_TYPE = 'BIOLOGICAL_ENTITY';
      this.entetyConditionsResult = this.createTableEntries(this.entetyVariables, SAMPLE_TYPE);
      return true;
    },
    updateBiol() {
      const SAMPLE_TYPE = 'BIOLOGICAL_SAMPLE';
      this.sampleConditionsResult = this.createTableEntries(this.sampleVariables, SAMPLE_TYPE);
      this.entetyAndSampleResult = this.crossProductSamples(this.entetyConditionsResult, this.sampleConditionsResult);
      return true;
    },
    updateTech() {
      const SAMPLE_TYPE = 'TECHNICAL_SAMPLE';
      this.techConditionsResult = this.createTableEntries(this.techVariables, SAMPLE_TYPE);
      this.result = this.crossProductSamples(this.entetyAndSampleResult, this.techConditionsResult);
      this.tmpResult = JSON.stringify(this.result);
      return true;
    },
    createTableEntries(Variables: TableVariable[], sampleType: string) {
      let entetyConditionCombinations = this.generateConditionCombinations(Variables);

      if (!entetyConditionCombinations.length) return null;

      entetyConditionCombinations = entetyConditionCombinations.map((combination) => {
        const concatName = combination.map(condition => Object.values(condition)[0]).join(' ; ');

        return {
          conditions: combination,
          externalDBID: '',
          secondaryName: concatName,
          count: '1',
          sampleType,
        };
      });

      return entetyConditionCombinations;
    },
    generateConditionCombinations(tableVariables: TableVariable[]) {
      const titledConditions: string[][] = [];
      const titles: string[] = [];

      for (const item of tableVariables) {
        const conditions: string[] = [];
        titles.push(item.title);

        for (const condition of item.conditions) {
          if (item.continuous) conditions.push(`${condition} ${item.unit}`);
          else conditions.push(`${condition}`);
        }

        titledConditions.push(conditions);
      }

      const factors = this.cartesianProduct(titledConditions);

      const factorList: { [key: string]: string }[][] = [];

      for (const factor of factors) {
        const combinationArr: { [key: string]: string }[] = [];

        for (let i = 0; i < factor.length; i++) {
          const conditionObj = { [titles[i]]: factor[i] };
          combinationArr.push(conditionObj);
        }

        factorList.push(combinationArr);
      }

      return factorList;
    },
    cartesianProduct(arr: Array<any>) {
      return arr.reduce((acc, val) => {
        return acc.map((el) => {
          return val.map((element) => {
            return el.concat([element]);
          });
        }).reduce((acc, val) => acc.concat(val), []);
      }, [[]]);
    },
    crossProductSamples(parents: combinedVariable[], childs: combinedVariable[]) {
      const result = [];

      for (const parent of parents) {
        if (Number(parent.count) >= 1) {
          for (const child of childs) {
            const newEntry = JSON.parse(JSON.stringify(child));
            newEntry.child = parent.secondaryName;
            newEntry.conditions.push(...parent.conditions);
            newEntry.secondaryName = `${parent.secondaryName} ; ${child.secondaryName}`;
            result.push(newEntry);
          }
        }
      }
      return result;
    },
    async onComplete() { 
      // Save entity conditions
      await this.createSamples(this.entetyConditionsResult, this.projectContext);

      // Save sample conditions
      await this.createSamples(this.sampleConditionsResult, this.projectContext);

      // Save technical conditions
      await this.createSamples(this.entetyAndSampleResult, this.projectContext);

      // Reset all variables
      // this.reset();
    },
 
    async createSamples(samples: any[] , projectContext: ProjectContext) {
      for (const sample of samples) {
        this.createSample(sample, projectContext);
      }
    },

    createSample(sample: Sample, projectContext: ProjectContext) {
      console.log("🚀 ~ createSample ~ sample:", sample)
      const sampleCreation = new openbis.SampleCreation();
      sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType));
      sampleCreation.setSpaceId(new openbis.SpacePermId(projectContext.space));
      sampleCreation.setCreationId(new openbis.CreationId(sample.secondaryName));

      // Iterate over conditions and set property for each
      for (const condition of sample.conditions) {
        for (const [key, value] of Object.entries(condition)) {
          sampleCreation.setProperty(key, value);
        }
      }

      if (sample.parent) {
        const parentSampleCreation = sampleCreationsDict[sample.parent];
        if (parentSampleCreation) {
          sampleCreation.setParentIds([parentSampleCreation.getCreationId()]);

          const parentChildIds = parentSampleCreation.getChildIds() || [];
          parentChildIds.push(sampleCreation.getCreationId());
          parentSampleCreation.setChildIds(parentChildIds);
        } else {
          console.log('Parent sample not found');
        }
      }

      return sampleCreation;
    },

    reset() {
      this.selectedVariables = [];
      this.variables = [
        { title: 'genotype', conditions: [], continuous: false, unit: null },
        { title: 'color', conditions: [], continuous: false, unit: null },
      ];
      this.projectContext = {
        UUID: '',
        space: null,
        name: null,
        contactPerson: null,
        manager: null,
        description: null,
      };
      this.entetyVariables = [
        { title: 'species', conditions: [""], continuous: false, unit: null },
      ];
      this.entetyConditionsResult = [];
      this.sampleVariables = [
        { title: 'tissue', conditions: [], continuous: false, unit: null },
      ];
      this.sampleConditionsResult = [];
      this.entetyAndSampleResult = [];
      this.techVariables = [
        { title: 'methods', conditions: [], continuous: false, unit: null },
      ];
      this.techConditionsResult = [];
      this.result = [];
      this.tmpResult = [];
    },
  },
  getters: {
    getEntetyConditionsResult(state): ConditionsResult[] {
      const SAMPLE_TYPE = 'BIOLOGICAL_ENTITY';
      let entetyConditionCombinations = state.entetyVariables.map(entety => ({
        title: entety.title,
        conditions: entety.conditions.map(condition => ({
          [entety.title]: entety.continuous ? `${condition} ${entety.unit}` : `${condition}`
        }))
      }));

      const conditions = entetyConditionCombinations.map(entety => entety.conditions);
      const cartesianProduct = this.cartesianProduct(conditions);

      const result = cartesianProduct.map(combination => {
        const combinedConditions = combination.reduce((acc, current) => ({ ...acc, ...current }), {});
        const secondaryName = Object.values(combinedConditions).join(' ; ');
        return {
          conditions: combinedConditions,
          externalDBID: '',
          secondaryName,
          count: '1',
          sampleType: SAMPLE_TYPE
        };
      });

      return result;
    }
  },
}); 
