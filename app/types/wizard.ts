
export interface ProjectContext {
  spaceCode: string ;
  projectCode: string ;
  contactPerson: string | null;
  experimentCode: string | null;
  manager: string | null;
  description: string | null;
}

export type Sample = {
  id: string;
  conditions: { propertyTitle: string, conditionTerm: string }[]; 
  externalDBID: string;
  name: string;
  count: number;
  parents: string[];
  pools: string[];
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

