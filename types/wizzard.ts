export type ProjectEntity = {
  title: string;
  conditions: Array<any>;
  continuous: boolean;
  unit: string | null;
};

export interface ProjectContext {
  UUID: string;
  space: string | null;
  code: string | null;
  contactPerson: string | null;
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