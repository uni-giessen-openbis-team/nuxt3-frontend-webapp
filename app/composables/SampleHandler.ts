import type { ProjectEntity, ProjectContext } from '../types/wizard';
import  openbis from '~/composables/openbis.esm';

export abstract class SampleHandler {
  samples: openbis.Sample[] = [];
  conditions: openbis.VocabularyTerm[] = [];
  projectContext: ProjectContext;
  protected sampleType: string;

  constructor(projectContext: ProjectContext, sampleType: string) {
    this.projectContext = projectContext;
    this.sampleType = sampleType;
  }
  
  protected static sanitizeName(name: string): string {
    return name.replace(/[^a-zA-Z0-9_]/g, '_');
  }

  private generateConditionCombinations(conditions: openbis.VocabularyTerm[]): Array<{ [key: string]: string }> {
    return conditions.reduce(this.createCombinedName, [{}]);
  }

  // This function creates a name for the sample by combining the conditions.
  // It is used to create unique sample codes.
  private createCombinedName(
    accumulator: Array<{ [key: string]: string }>,
    condition: openbis.VocabularyTerm
  ): Array<{ [key: string]: string }> {
    return accumulator.flatMap(x => 
      condition.map(term => ({ ...x, [condition.code]: term.code }))
    );
  }   
  
  private prepareSample( sampleCode: string, conditions?: openbis.VocabularyTerm[]): openbis.SampleCreation {
    const sample = new openbis.SampleCreation();
    sample.setTypeId(new openbis.EntityTypePermId(this.SampleType ));
    sample.setSpaceId(new openbis.SpacePermId(this.projectContext.spaceCode));
    sample.setExperimentId(new openbis.ExperimentIdentifier(this.projectContext.spaceCode + "/" + this.projectContext.projectCode + "/" + this.projectContext.experimentCode));
    sample.setCode(sampleCode);

    // iterate over the conditions and set the properties
    if (conditions) {
      for (const condition of conditions) {
        sample.setProperty(condition.getVocabulary().getCode(), condition.getCode());
      }
    }
    return sample;
  }

  protected crossProductSamples(parents: Sample[], children: Sample[]): Sample[] {
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

  constructor(projectContext: ProjectContext, entityVariables: ProjectEntity[]) {
    super(projectContext, "ENTITY_SAMPLE_TYPE");
    this.entityVariables = entityVariables;
  }

  public updateEntitySamples(): Sample[] {
    const entitySamples = this.createTableEntries(this.entityVariables);
    this.samples = entitySamples;
    return this.samples;
  }

  private createTableEntries(variables: ProjectEntity[]): Sample[] {
    // Implementation of createTableEntries method
    // This should create Sample objects based on the entity variables
    // Similar to how it's done in other handlers
  }
}

export class BiologicalSampleHandler extends SampleHandler {

  constructor(projectContext: ProjectContext) {
    super(projectContext, "BIOLOGICAL_SAMPLE_TYPE");
  }

  // we need the enteties and the samples to make the cross product

  

  // make the cross products of the samples 
  public updateBiologicalVariables(entityConditionsResult: Sample[]): Sample[] {
    const biologicalSamples = this.createTableEntries(this.sampleVariables);
    this.samples = this.crossProductSamples(entityConditionsResult, biologicalSamples);
    return this.samples;
  }
}

export class TechnicalSampleHandler extends SampleHandler {
  private readonly technicalVariables: ProjectEntity[];

  constructor(technicalVariables: ProjectEntity[], projectContext: ProjectContext) {
    super(projectContext, "TECHNICAL_SAMPLE_TYPE");
    this.technicalVariables = technicalVariables;
  }

  public updateTechnicalVariables(entityAndSampleResult: Sample[]): Sample[] {
    const technicalSamples = this.createTableEntries(this.technicalVariables);
    this.samples = this.crossProductSamples(entityAndSampleResult, technicalSamples);
    return this.samples;
  }
}