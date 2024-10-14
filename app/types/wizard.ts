

export interface ProjectContext {
  spaceCode: string ;
  projectCode: string ;
  contactPerson: string | null;
  experimentCode: string | null;
  manager: string | null;
  description: string | null;
}

export type Sample = {
  conditions: { propertyTitle: string, conditionTitle: string }[]; 
  externalDBID: string;
  secondaryName: string;
  count: string;
  sampleType: string;
  parent?: string;
};

 
export type PropertyWithVocabulary  = {
  vocabulary: Vocabulary;
  title: string;
  description?: string;
  conditions: VocabularyTerm[];
};

export type  PropertyWithoutVocabulary  = {
  title: string;
  continuous: boolean;
  unit: string | null;
  description?: string;
  conditions: VocabularyTerm[];
};


export type Property = PropertyWithVocabulary | PropertyWithoutVocabulary;

export type VocabularyTerm = {
  title: string;
  description?: string;
  code?: string;
}

export type Vocabulary= {
  title: string;
  description?: string;
  code: string;
  terms: VocabularyTerm[];
}

