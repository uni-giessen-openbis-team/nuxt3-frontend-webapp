import type openbis from "./openbis.esm";

abstract class BaseProperty {
    constructor(
      public title: string,
      public conditions: Array<string>,
      public code: string,
      public label: string
    ) {}

    get combinedConditions(): Array<{ [key: string]: string }> {
      return this.conditions.reduce(this.createPropertyCombinations, [{}]);
    }

    private createPropertyCombinations(
      accumulator: Array<{ [key: string]: string }>,
      condition: string
    ): Array<{ [key: string]: string }> {
      return accumulator.flatMap(x =>
        condition.split(',').map(term => ({ ...x, [condition]: term.trim() }))
      );
    }
  }

  export class PropertyWithVocabularyCode extends BaseProperty {
    public vocabularyTerms: openbis.VocabularyTerm[] = [];

    constructor(
      title: string,
      code: string,
      label: string,
      public vocabularyCode: string | null
    ) {
      super(title, [], code, label);
    }
  
    
  // Define an async method to fetch and store vocabulary terms
      async loadVocabularyTerms(): Promise<void> {
        if (this.vocabularyCode) {
          this.vocabularyTerms = await listVocabularyTermsByVocabularyId(this.vocabularyCode);
        } else {
          this.vocabularyTerms = [];
        }
      }
  }
  export class PropertyWithoutVocabularyCode extends BaseProperty {
    continuous: boolean;
    unit: null;
    constructor(
      title: string,
      code: string,
      label: string
    ) {
      super(title, [], code, label);
      this.continuous = false;
      this.unit = null;
    }    
  } 