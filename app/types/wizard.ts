export type ProjectEntity = {
  title: string;
  conditions: Array<Condition>;
  continuous: boolean;
  unit: string | null;
  vocabularyCode: string | null;
};

export type Condition = {
  code: string;
  label: string;
};

export interface ProjectContext {
  spaceCode: string ;
  projectCode: string ;
  contactPerson: string | null;
  experimentCode: string | null;
  manager: string | null;
  description: string | null;
}

export type TableVariable = {
  title: string;
  conditions: Array<string | number>;
  continuous: boolean;
  unit: string | null;
};

export type combinedVariable = {
  conditions: Array<{ [key: string]: string }>;
  externalDBID: string;
  secondaryName: string;
  count: string;
  sampleType: string;
  child?: string;
};


export type Sample = {
  conditions: { [key: string]: string }[];
  externalDBID: string;
  secondaryName: string;
  count: string;
  sampleType: string;
  parent?: string;
};


export type PropertyWithVocabulary = BaseProperty & {
  vocabularyCode: string;
};

export type  PropertyWithoutVocabulary = BaseProperty & {
  continuous: boolean;
  unit: string | null;
};

export type BaseProperty = {
  title: string;
  description: string;
  conditions: Condition[];
}

export type Property = PropertyWithVocabulary | PropertyWithoutVocabulary;
