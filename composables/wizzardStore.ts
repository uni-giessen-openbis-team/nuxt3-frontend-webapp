import { defineStore } from 'pinia';
import type { ProjectEntity, ProjectContext, TableVariable, combinedVariable } from '@/types/wizzard';
import openbis from './openbis.esm';
import useOpenbis from '~/plugins/useOpenbis';

/**
 * Variables are the building blocks of the wizzard. They are used to define the
 * conditions that will be used to create the samples. The cross product of the
 * variables will be used to create the samples.
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
    spaceContext: {
      code: '',
    },

    projectContext: {
      UUID: '',
      space: null,
      code: '',
      contactPerson: null,
      manager: null,
      description: null,
    } as ProjectContext,

    collectionContext: {
      code: '',
      typeId: '',
      description: '',
    },


    projectContext: {
      UUID: '',
      code: '',
      contactPerson: null,
      manager: null,
      description: null,
    } as ProjectContext,

    selectedBiologicalEntityVariables: [] as ProjectEntity[],

    biologicalSampleVariables: [
      {
        title: 'genotype',
        conditions: [],
        continuous: false,
        unit: null,
        vocabularyCode: "",
      },
      {
        title: 'color',
        conditions: [],
        continuous: false,
        unit: null,
      },
    ] as ProjectEntity[],


    entetyVariables: [
      {
        title: 'species',
        conditions: [""],
        continuous: false,
        unit: null,
        vocabularyCode: "Q_NCBI_TAXONOMY",
      },
    ] as ProjectEntity[],
    entetyConditionsResult: [] as Sample[],
    sampleVariables: [
      {
        title: 'tissue',
        conditions: [],
        continuous: false,
        unit: null,
        vocabularyId: "null",
      },
    ] as unknown as ProjectEntity[],
    sampleConditionsResult: [] as Sample[],
    entetyAndSampleResult: [] as Sample[],
    techVariables: [
      {
        title: 'Method',
        conditions: [],
        continuous: false,
        unit: null,
        vocabularyCode: null, 
      },
    ] as ProjectEntity[],
    techConditionsResult: [] as Sample[],
    result: [] as Sample[],
    tmpResult: [] as string[],
    spaceId: null,
    projectId: null,
  }),

  actions: {
    /**
     * Adds a new variable to the list of variables.
     * @param variable - The variable to add.
     */
    addVariable(variable: ProjectEntity) {
      this.biologicalSampleVariables.push(variable);
    },
    /**
     * Removes a variable from the list of variables by its title.
     * @param title - The title of the variable to remove.
     */
    removeVariable(title: string) {
      this.biologicalSampleVariables = this.biologicalSampleVariables.filter(variable => variable.title !== title);
    },
    /**
     * Updates the entity conditions result by creating table entries for the entity variables.
     * @returns {boolean} - Returns true if the update is successful.
     */
    updateEntety() {
      const SAMPLE_TYPE = 'BIOLOGICAL_ENTITY';
      this.entetyConditionsResult = this.createTableEntries(this.entetyVariables, SAMPLE_TYPE);
      return true;
    },
    /**
     * Updates the biological sample conditions result by creating table entries for the sample variables.
     * Combines the entity and sample results.
     * @returns {boolean} - Returns true if the update is successful.
     */
    updateBiol() {
      const SAMPLE_TYPE = 'BIOLOGICAL_SAMPLE';
      this.sampleConditionsResult = this.createTableEntries(this.sampleVariables, SAMPLE_TYPE);
      this.entetyAndSampleResult = this.crossProductSamples(this.entetyConditionsResult, this.sampleConditionsResult);
      return true;
    },
    /**
     * Updates the technical sample conditions result by creating table entries for the technical variables.
     * Combines the entity, sample, and technical results.
     * @returns {boolean} - Returns true if the update is successful.
     */
    updateTech() {
      const SAMPLE_TYPE = 'TECHNICAL';
      this.techConditionsResult = this.createTableEntries(this.techVariables, SAMPLE_TYPE);
      this.result = this.crossProductSamples(this.entetyAndSampleResult, this.techConditionsResult);
      this.tmpResult = JSON.stringify(this.result);
      return true;
    },
    /**
     * Creates table entries for the given variables and sample type.
     * @param Variables - The variables to create table entries for.
     * @param sampleType - The type of the sample.
     * @returns {Sample[]} - The created table entries.
     */
    sanitizeName (name: string)  {
      return name.replace(/[^a-zA-Z0-9_]/g, '_');
    },

    createTableEntries(Variables: TableVariable[], sampleType: string) {
      let entetyConditionCombinations = this.generateConditionCombinations(Variables);
      if (!entetyConditionCombinations.length) return []; // Changed from return null to return []
      entetyConditionCombinations = entetyConditionCombinations.map((combination) => {
        const concatName = combination.map(condition => this.sanitizeName(Object.values(condition)[0])).join('_');
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
    /**
     * Generates condition combinations for the given table variables.
     * @param tableVariables - The table variables to generate condition combinations for.
     * @returns {Array<{ [key: string]: string }[]>} - The generated condition combinations.
     */
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
    /**
     * Generates the cartesian product of the given array.
     * @param arr - The array to generate the cartesian product for.
     * @returns {Array<any>} - The cartesian product.
     */
    cartesianProduct(arr: Array<any>) {
      return arr.reduce((acc: any[], val: any[]) => {
        return acc.map((el: any[]) => {
          return val.map((element: any) => {
            return el.concat([element]);
          });
        }).reduce((acc: any[], val: any[]) => acc.concat(val), []);
      }, [[]]);
    },

    /**
     * Generates the cross product of the parent and child samples.
     * @param parents - The parent samples.
     * @param childs - The child samples.
     * @returns {Sample[]} - The cross product of the parent and child samples.
     */
    crossProductSamples(parents: combinedVariable[], children: combinedVariable[]) {
      const result = [];

      for (const parent of parents) {
        if (Number(parent.count) >= 1) {
          for (const child of children) {
            const newEntry = JSON.parse(JSON.stringify(child));
            newEntry.child = parent.secondaryName;
            newEntry.conditions.push(...parent.conditions);
            newEntry.secondaryName = `${parent.secondaryName}_${child.secondaryName}`;
            result.push(newEntry);
          }
        }
      }
      return result;
    },
    /**
     * Completes the sample creation process by saving entity, sample, and technical conditions.
     */
    async onComplete() {
      // The biological samples need to be saved in the user defined materials/Samples
      // as an object or sample
      console.log("🚀 ~ onComplete is running", this.sampleConditionsResult)
      await this.createSamples(this.sampleConditionsResult);

      // The Technical Samples are children of the Biological Samples. 
    
      await this.createTechnicalSamples(this.result, this.projectContext);


    },

    async createSamples(samples: Sample[]) {
      const sampleCreations:openbis.SampleCreation[] = [];
      for (const sample of samples) {
        if (sample.sampleType === 'BIOLOGICAL') {
          const entityCreation = await this.prepareSample(sample, this.projectContext);
          sampleCreations.push(entityCreation);
        }
        else if(sample.sampleType== 'TECHNICAL') 
        {
          const technicalCreation = await this.prepareTechnicalSample(sample, this.projectContext);
          sampleCreations.push(technicalCreation);

        }
      }
      useOpenBisStore().v3?.createSamples(sampleCreations);
    },

    async prepareSample(entity: Sample, projectContext: ProjectContext):Promise<openbis.SampleCreation> {
      const sampleCreation = new openbis.SampleCreation();
      console.log("🚀 ~ prepareSample ~ entity:", entity)
      // The enteties are saved in the Space Materials/Samples Info
      sampleCreation.setCode(entity.secondaryName);
      sampleCreation.setSpaceId(new openbis.SpacePermId("MATERIALS"))
      sampleCreation.setTypeId(new openbis.EntityTypePermId("BIOLOGICAL"));
      sampleCreation.setExperimentId(new openbis.ExperimentIdentifier("/MATERIALS/SAMPLES/GENERAL_SAMPLES"));
      return sampleCreation;
    },

    async createTechnicalSamples(samples: Sample[], projectContext: ProjectContext) {
      console.log("🚀 ~ createTechnicalSamples ~ samples:", samples)
      const sampleCreations:openbis.SampleCreation[] = [];
      const dataSetCreations:openbis.DataSetCreation[] = [];
      for (const sample of samples) {
        const entityCreation = await this.prepareTechnicalSample(sample, this.projectContext);
        const dataSetCreation = await this.prepareDataSet(sample, this.projectContext);
        sampleCreations.push(entityCreation);
        dataSetCreations.push(dataSetCreation);
      }
      // create Datasets for the TechnicalSamples
      useOpenBisStore().v3?.createSamples(sampleCreations);
      useOpenBisStore().v3?.createDataSets(dataSetCreations);
    },

    async prepareDataSet(sample: Sample, projectContext: ProjectContext):Promise<openbis.DataSetCreation> {

      const dataSetCreation = new openbis.DataSetCreation();
      dataSetCreation.setCode(sample.secondaryName);
      dataSetCreation.setSampleId(new openbis.SamplePermId(sample.secondaryName));
      dataSetCreation.setTypeId(new openbis.EntityTypePermId("ANALYZED_DATA"));
      return dataSetCreation;
    },

    async prepareTechnicalSample(sample: Sample, projectContext: ProjectContext):Promise<openbis.SampleCreation> {
      const sampleCreation = new openbis.SampleCreation();
      // The enteties are saved in the Space Materials/Samples Info
      sampleCreation.setCode(sample.secondaryName);
      sampleCreation.setSpaceId(new openbis.SpacePermId(this.spaceContext.code as string))
      sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType));
      sampleCreation.setExperimentId(new openbis.ExperimentPermId(this.collectionContext.code));
      return sampleCreation;
    },

    /**
     * Resets the store to its initial state.
     */
    reset() {
      this.selectedBiologicalEntityVariables = [];
      this.biologicalSampleVariables = [
        { title: 'genotype', conditions: [], continuous: false, unit: null, vocabularyCode: null },
        { title: 'color', conditions: [], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.projectContext = {
        UUID: '',
        space: null,
        code: null,
        contactPerson: null,
        manager: null,
        description: null,
      };
      this.entetyVariables = [
        { title: 'species', conditions: [""], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.entetyConditionsResult = [];
      this.sampleVariables = [
        { title: 'tissue', conditions: [], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.sampleConditionsResult = [];
      this.entetyAndSampleResult = [];
      this.techVariables = [
        { title: 'methods', conditions: [], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.techConditionsResult = [];
      this.result = [];
      this.tmpResult = [];
    },
  },
  getters: {
    /**
     * Gets the entity conditions result by generating the cartesian product of the entity variables.
     * @param state - The state of the store.
     * @returns {ConditionsResult[]} - The entity conditions result.
     */
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

      const result = cartesianProduct.map((combination: Array<{ [key: string]: string }>) => {
        const combinedConditions = combination.reduce((acc, current) => ({ ...acc, ...current }), {});
        const secondaryName = Object.values(combinedConditions).join('_');
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

