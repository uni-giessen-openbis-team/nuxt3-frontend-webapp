import type { ProjectEntity, TableVariable } from '../types/wizard';

export class SampleHandler {
  protected sampleType: string;
  protected conditionsResult: Sample[];
  protected samples: Sample[];

  constructor(sampleType: string) {
    this.sampleType = sampleType;
    this.conditionsResult = [];
    this.samples = [];
  }

  protected sanitizeName(name: string): string {
    return name.replace(/[^a-zA-Z0-9_]/g, '_');
  }

  // Create new samples based on the table variables
  protected createTableEntries(variables: TableVariable[]): Sample[] {
    const combinations = this.generateConditionCombinations(variables);
    return combinations.map((combination, index) => ({
      id: `${this.sampleType}_${index + 1}`,
      type: this.sampleType,
      properties: combination
    }));
  }

  // Generate all possible combinations of conditions for the given table variables
  protected generateConditionCombinations(tableVariables: TableVariable[]): Array<{ [key: string]: string }> {
    const conditions = tableVariables.map(variable => 
      variable.values.map(value => ({ [variable.name]: value }))
    );
    return this.cartesianProduct(conditions);
  }

  protected cartesianProduct(arr: Array<any>): Array<any> {
    return arr.reduce((a, b) => 
      a.flatMap(x => b.map(y => ({ ...x, ...y }))),
      [{}]
    );
  }

  // Create new samples by combining theprevious layer of samples with the current layer of samples
  private crossProductSamples(parents: Sample[], children: Sample[]): Sample[] {
    return parents.flatMap(parent => 
      children.map(child => ({
        ...child,
        id: `${parent.id}_${child.id}`,
        properties: { ...parent.properties, ...child.properties }
      }))
    );
  }
}


export class EntitySampleHandler extends SampleHandler {
  private entityVariables: ProjectEntity[];

  constructor(entityVariables: ProjectEntity[]) {
    super('BIOLOGICAL_ENTITY');
    this.entityVariables = entityVariables;
  }

  public updateEntityVariables(): boolean {
    this.conditionsResult = this.createTableEntries(this.entityVariables);
    this.samples = this.conditionsResult;
    return true;
  }
}


export class BiologicalSampleHandler extends SampleHandler {
  private sampleVariables: ProjectEntity[];

  constructor(sampleVariables: ProjectEntity[]) {
    super('BIOLOGICAL');
    this.sampleVariables = sampleVariables;
  }

  public updateBiologicalVariables(entityConditionsResult: Sample[]): boolean {
    this.conditionsResult = this.createTableEntries(this.sampleVariables);
    this.samples = this.crossProductSamples(entityConditionsResult, this.conditionsResult);
    return true;
  }
}


export class TechnicalSampleHandler extends SampleHandler {
  private technicalVariables: ProjectEntity[];

  constructor(technicalVariables: ProjectEntity[]) {
    super('TECHNICAL');
    this.technicalVariables = technicalVariables;
  }

  public updateTechnicalVariables(entityAndSampleResult: Sample[]): boolean {
    this.conditionsResult = this.createTableEntries(this.technicalVariables);
    this.samples = this.crossProductSamples(entityAndSampleResult, this.conditionsResult);
    return true;
  }

  public async prepareTechnicalSample(sample: Sample, spaceContext: any, collectionContext: any): Promise<{ sampleCode: string; properties: Record<string, any> }> {
    // Placeholder implementation
    return {
      sampleCode: `${this.sanitizeName(sample.id)}_${Date.now()}`,
      properties: {
        ...sample.properties,
        SPACE: spaceContext.code,
        COLLECTION: collectionContext.code
      }
    };
  }

}