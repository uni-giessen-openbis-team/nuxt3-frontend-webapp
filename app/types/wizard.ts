
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

