// Types from the workflow service
export interface Workflow {
  UUID: string
  description: string
  language: string
  name: string
  repository: string
}

export interface VersionParameter {
  caption: string
  command: string[]
  constraints?: {
    interval?: {
      max?: number
      min?: number
      steps?: number
    }
    list?: string[]
    extensions?: string[]
  }
  default?: string
  false_command?: string[]
  label: string
  name: string
  required: boolean
  type: string
}

export interface TableParameter {
  columns: {
    caption: string
    header: string
    label: string
    name: string
    required: boolean
    type: string
    constraints?: {
      extensions: string[]
    }
  }[]
  format: string
  header_line: boolean
}

interface TableSchema {
  $schema: string
  additionalProperties: boolean
  properties: {
    rows: {
      items: {
        [key: string]: {
          pattern?: string
          type: string
        }
      }
      type: string
    }
  }
  required: string[]
  type: string
}

interface ParameterSchema {
  $schema: string
  additionalProperties: boolean
  properties: {
    domain: {
      enum: string[]
      type: string
    }
    reference: {
      pattern: string
      type: string
    }
    sensitive: {
      type: string
    }
    threshold: {
      maximum: number
      minimum: number
      type: string
    }
  }
  required: string[]
  type: string
}

export interface Version {
  UUID: string
  deprecated: boolean
  design_table_definition: TableParameter
  design_table_schema: TableSchema
  fixed_parameters: string
  git_tag: string
  input_directory: string
  name: string
  output_file_patterns: {
    paths: {
      pattern: string
    }[]
  }
  parameter_definition: {
    parameters: VersionParameter[]
  }
  parameter_schema: ParameterSchema
  release_date: string
  use_conda: boolean
  use_singularity: boolean
}

export interface SchemaField {
  type: string
  label: string
  name: string
  validation?: string
  help?: string
  value?: string | boolean
  step?: string
  min?: string
  max?: string
  list?: []
  extensions?: string[]
}
