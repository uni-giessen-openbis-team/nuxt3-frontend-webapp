import { defineStore } from 'pinia';
import type { ProjectEntity, ProjectContext, TableVariable, combinedVariable } from '@/types/wizard';
import openbis from './openbis.esm';

/**
 * Variables are the building blocks of the wizard. They are used to define the
 * conditions that will be used to create the samples. The cross product of the
 * variables will be used to create the samples.
 */

type Sample = {
  conditions: { [key: string]: string }[];
  externalDBID: string;
  secondaryName: string;
  count: string;
  sampleType: string;
  parent?: string;
};

export const useWizardStore = defineStore('wizardStore', {
  state: () => ({
    spaceContext: {
      code: '',
    },

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


    entityVariables: [
      {
        title: 'species',
        conditions: [""],
        continuous: false,
        unit: null,
        vocabularyCode: "Q_NCBI_TAXONOMY",
      },
    ] as ProjectEntity[],
    entityConditionsResult: [] as Sample[],
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
    technicalVariables: [
      {
        title: 'Method',
        conditions: [],
        continuous: false,
        unit: null,
        vocabularyCode: null,
      },
    ] as ProjectEntity[],
    technicalConditionsResult: [] as Sample[],
    technicalSamples: [] as Sample[],
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
    updateEntityVariables() {
      console.log("updateEntityVariables")
      const SAMPLE_TYPE = 'BIOLOGICAL_ENTITY';
      this.entityConditionsResult = this.createTableEntries(this.entityVariables, SAMPLE_TYPE);
      return true;
    },
    /**
     * Updates the biological sample conditions result by creating table entries for the sample variables.
     * Combines the entity and sample results.
     * @returns {boolean} - Returns true if the update is successful.
     */
    updateBiologicalVariables() {
      const SAMPLE_TYPE = 'BIOLOGICAL';
      this.sampleConditionsResult = this.createTableEntries(this.sampleVariables, SAMPLE_TYPE);
      this.entetyAndSampleResult = this.crossProductSamples(this.entityConditionsResult, this.sampleConditionsResult);
      return true;
    },
    /**
     * Updates the technical sample conditions result by creating table entries for the technical variables.
     * Combines the entity, sample, and technical results.
     * @returns {boolean} - Returns true if the update is successful.
     */
    updateTechnicalVariables() {
      const SAMPLE_TYPE = 'TECHNICAL';
      this.technicalConditionsResult = this.createTableEntries(this.technicalVariables, SAMPLE_TYPE);
      this.technicalSamples = this.crossProductSamples(this.entetyAndSampleResult, this.technicalConditionsResult);
      this.tmpResult = JSON.stringify(this.technicalSamples);
      return true;
    },




    /**
     * Creates table entries for the given variables and sample type.
     * @param Variables - The variables to create table entries for.
     * @param sampleType - The type of the sample.
     * @returns {Sample[]} - The created table entries.
     */
    sanitizeName(name: string) {
      return name.replace(/[^a-zA-Z0-9_]/g, '_');
    },

    createTableEntries(Variables: TableVariable[], sampleType: string) {
      let entetyConditionCombinations = this.generateConditionCombinations(Variables);
      if (!entetyConditionCombinations.length) return [];
      entetyConditionCombinations = entetyConditionCombinations.map((combination) => {
        const concatName = combination.map(condition => this.sanitizeName(Object.values(condition)[0])).join('_');
        return {
          conditions: combination,
          externalDBID: '',
          secondaryName: concatName,
          count: '1',
          sampleType,
        } as Sample;
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

    crossProductSamples(parents: combinedVariable[], children: combinedVariable[]): Sample[] {
      const result = [];
      for (const parent of parents) {
        if (Number(parent.count) >= 1) {
          for (const child of children) {
            const newEntry: Sample = JSON.parse(JSON.stringify(child));
            newEntry.parent = parent.secondaryName;
            newEntry.conditions.push(...parent.conditions);
            newEntry.secondaryName = `${parent.secondaryName}_${child.secondaryName}`;
            result.push(newEntry);
          }
        }
      }
      return result;
    },

    async onComplete() {
      await this.createSamples();

    },

    async createSamples() {
      //  Biological Samples. 

      const biologicalSampleCreations: openbis.SampleCreation[] = [];
      for (const sample of this.entetyAndSampleResult) {
        const creation = await this.prepareBiologicalSample(sample);
        biologicalSampleCreations.push(creation);
      }

      const technicalSampleCreations: openbis.SampleCreation[] = [];
      
      for (const sample of this.technicalSamples) {
        const entityCreation = await this.prepareBiologicalSample(sample);
        biologicalSampleCreations.push(entityCreation);
      }

      //iterate over the technical samplesCreation 
      for (const biologicalSampleCreation of biologicalSampleCreations) {
        // iterate over all samples
        for (const sample of this.technicalSamples) {
          // of a name is eq, and has a child, set this child
          if (biologicalSampleCreation.getCode() === sample.secondaryName && sample.parent) {
            // find the technical sampleCreation with the name 
            const technicalSampleCreation = technicalSampleCreations.find(ts => ts.getCode() === sample.parent);
            // set the parent in the technical sample
            technicalSampleCreation?.setParentIds([biologicalSampleCreation?.getCreationId()]);
          }
        }
      }

      useOpenBisStore().v3?.createSamples(technicalSampleCreations);
    },


    async prepareBiologicalSample(sample: Sample): Promise<openbis.SampleCreation> {
      const sampleCreation = new openbis.SampleCreation();
      // The enteties are saved in the Space Materials/Samples Info
      sampleCreation.setCode(sample.secondaryName);
      sampleCreation.setSpaceId(new openbis.SpacePermId("MATERIALS"))
      sampleCreation.setTypeId(new openbis.EntityTypePermId("BIOLOGICAL"));
      sampleCreation.setCreationId(new openbis.CreationId(sample.secondaryName));
      sampleCreation.setExperimentId(new openbis.ExperimentIdentifier("/MATERIALS/SAMPLES/GENERAL_SAMPLES"));

      return sampleCreation;
    },


    async prepareTechnicalSample(sample: Sample): Promise<openbis.SampleCreation> {
      const sampleCreation = new openbis.SampleCreation();
      // The enteties are saved in the Space Materials/Samples Info
      sampleCreation.setCode(sample.secondaryName);
      sampleCreation.setSpaceId(new openbis.SpacePermId(this.spaceContext.code as string))
      sampleCreation.setTypeId(new openbis.EntityTypePermId(sample.sampleType));
      sampleCreation.setExperimentId(new openbis.ExperimentPermId(this.collectionContext.code));
      sampleCreation.setCreationId(new openbis.CreationId(sample.secondaryName));
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
        spaceCode: null,
        code: null,
        contactPerson: null,
        manager: null,
        description: null,
      };
      this.entityVariables = [
        { title: 'species', conditions: [""], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.entityConditionsResult = [];
      this.sampleVariables = [
        { title: 'tissue', conditions: [], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.sampleConditionsResult = [];
      this.entetyAndSampleResult = [];
      this.technicalVariables = [
        { title: 'methods', conditions: [], continuous: false, unit: null, vocabularyCode: null },
      ];
      this.technicalConditionsResult = [];
      this.technicalSamples = [];
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
      const entetyConditionCombinations = state.entityVariables.map(entety => ({
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

