export interface TableVariable {
    title: string
    conditions: (string | number)[]
    continous: boolean
    unit: string | null
  }
  
  export interface combinedVariable {
    secondaryName: string
    externalDBIDL: string
    count?: number
    unit?: string
    conditions?: Array
  }