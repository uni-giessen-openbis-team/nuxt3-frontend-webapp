import openbis from '~/composables/openbis.esm';
import  { PropertyWithoutVocabularyCode , PropertyWithVocabularyCode } from '~/composables/PropertiesClass';

export abstract class SampleHandler {
  public items: Array<PropertyWithVocabularyCode | PropertyWithoutVocabularyCode > = [];
  public conditions: Array<string> = [];
  public sampleCreations: openbis.SampleCreation[] = []; // Add this line to store sample creations
  parentSampleHandler?: SampleHandler;

  constructor(
    public spaceCode: string,
    public projectCode: string,
    public experimentCode: string | null,
    protected sampleType: string,
    public manager: string | null,
    public description: string | null,
    public properties: Array<PropertyWithVocabularyCode | PropertyWithoutVocabularyCode>,
    public collectionId: string | null,
  ) { 
  }

  // Getter to create combinations of properties
  get propertyCombinations(): Array<{ [key: string]: string }> {
    console.log('properties', this.properties , "parent properties", this.parentSampleHandler?.properties);
    const combinedProperties = this.properties.reduce((acc, property) => {
      return this.combinePropertyConditions(acc, property.conditions, property.code);
    }, [{}]);

    if (this.parentSampleHandler) {
      const parentCombinations = this.parentSampleHandler.propertyCombinations;
      return this.crossProductProperties(parentCombinations, combinedProperties);
    }
    return combinedProperties;
  }

  private crossProductProperties(
    parentProps: Array<{ [key: string]: string }>,
    childProps: Array<{ [key: string]: string }>
  ): Array<{ [key: string]: string }> {
    return parentProps.flatMap(parent =>
      childProps.map(child => ({
        ...parent,
        ...child,
        name: `${parent.name}_${child.name}`
      }))
    );
  }

  private combinePropertyConditions(
    accumulator: Array<{ [key: string]: string }>,
    conditions: Array<string>,
    code: string
  ): Array<{ [key: string]: string }> {
    return accumulator.flatMap(acc =>
      conditions.map(condition => {
        const uniqueValues = new Set(Object.values(acc).filter(Boolean)); // Create a Set for unique values
        const combinedName = 
          `${[...uniqueValues].join('_')}${uniqueValues.size > 0 ? '_' : ''}${condition}`; // Updated line
        
        return {
          ...acc,
          [code]: condition,
          name: combinedName
        };
      })
    );
  }

  createSampleCreations() {
    // if a parent exist, also take the props of the sampleCreations and
    // create combinations of the parent and the current sampleCreations
      this.sampleCreations  =  this.propertyCombinations.map((props) => {
        return this.createSampleCreation(props?.name ?? '', Object.entries(props));
      });
  }

  private createSampleCreation(sampleCode: string, properties: [string, string][], parentSampleCreation?: openbis.SampleCreation| openbis.Sample): openbis.SampleCreation {
    const sample = new openbis.SampleCreation();
    sample.setTypeId(new openbis.EntityTypePermId(this.sampleType));
    sample.setSpaceId(new openbis.SpacePermId(this.spaceCode));
    sample.setExperimentId(new openbis.ExperimentIdentifier(`${this.spaceCode}/${this.projectCode}/${this.experimentCode}`));
    sample.setCode(sampleCode);

    // Set the creationId to the sampleCode (name)
    sample.setCreationId(new openbis.CreationId(sampleCode));
  
    // Iterate over the properties and set them
    properties.forEach(([key, value]) => {
      if (key !== 'name') {
        sample.setProperty(key, value);
      }
    });

    // Set the name property
    sample.setProperty('name', sampleCode);

    // Set the parent sample creation
    if (parentSampleCreation && parentSampleCreation instanceof openbis.SampleCreation) {
      sample.setParentIds([parentSampleCreation.getCreationId()]);
    }
    else if (parentSampleCreation && parentSampleCreation instanceof openbis.Sample) {
      sample.setParentIds([parentSampleCreation.getCode()]);
    }
    return sample;
  }

  protected crossProductSamples(parents: openbis.SampleCreation[], children: openbis.SampleCreation[]): openbis.SampleCreation[] {
    return parents.flatMap(parent =>
      children.map(child => ({
        ...child,
        id: `${parent.getCode()}_${child.getCode()}`,
        properties: { ...parent.getProperties(), ...child.getProperties()  }
      }))
    );
  }


  async createSamples() {
    const samples = this.createSampleCreations();
    useOpenBisStore().v3?.createSamples(this.sampleCreations);
  }

  // Add a property to the properties array
  addProperty(property: PropertyWithVocabularyCode | PropertyWithoutVocabularyCode) {
    this.properties.push(property);
  }

  // Remove a property from the properties array
  removeProperty(property: PropertyWithVocabularyCode | PropertyWithoutVocabularyCode) {
    const index = this.properties.findIndex(p => p === property);
    if (index !== -1) {
      this.properties.splice(index, 1);
    }
  }  
}

export class EntitySampleHandler extends SampleHandler {

  constructor(spaceCode: string, projectCode: string, collectionId: string) { 
    super(spaceCode, projectCode, null, 'ENTITY_SAMPLE_TYPE', null, null, [], collectionId);

    const properties = [
      new PropertyWithoutVocabularyCode('Species', 'NCBI_ID', 'Species'),
      new PropertyWithoutVocabularyCode('Genus', 'GENUS_ID', 'Genus'),
      new PropertyWithVocabularyCode('Family', 'FAMILY_ID', 'Family', 'Q_FAMILY_ORGANISM')
    ]; 

    this.items.push(...properties);
  }
}

export class BiologicalSampleHandler extends SampleHandler {
  override  parentSampleHandler: EntitySampleHandler  ;

  constructor(
    spaceCode: string,
    projectCode: string,
    collectionId: string,
    parentSampleHandler: EntitySampleHandler
  ) {
    super(spaceCode, projectCode, null, 'BIOLOGICAL_SAMPLE_TYPE', null, null, [], collectionId);
    this.parentSampleHandler = parentSampleHandler;

    const properties = [
      new PropertyWithoutVocabularyCode('Tissue', 'TISSUE_ID', 'Tissue'),
    ]; 

    this.items.push(...properties);
  }
  
}

export class TechnicalSampleHandler extends BiologicalSampleHandler {

  constructor(
    spaceCode: string,
    projectCode: string,
    collectionId: string,
    parentSampleHandler: BiologicalSampleHandler
  ) {
    super(spaceCode, projectCode, collectionId, parentSampleHandler);
    this.sampleType = 'TECHNICAL_SAMPLE_TYPE'; // Overwrite the sample type
    this.parentSampleHandler = parentSampleHandler;
  }

  // override the createSamples method to create a 
}
