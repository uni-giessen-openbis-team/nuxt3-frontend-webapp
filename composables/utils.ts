import type { TableVariable } from '@/types/wizzard'

export function createCombinations(Variables: TableVariable[]) {
  const entetyConditionCombinations = generateConditionCombinations(Variables)

  // Check if entetyConditionCombinations is an empty array
  if (!entetyConditionCombinations.length)
    return null

  for (const item of entetyConditionCombinations) {
    // add count field
    item.count = '1'

    // construct ExternalDBID field
    const keys = Object.keys(item).filter(key => key !== 'count')
    const concatProduct = keys.map(key => item[key]).join(' ; ')
    item.externalDBID = ''

    // add secondaryName field
    item.secondaryName = concatProduct // replace this with actual value
  }
  return entetyConditionCombinations
}

function generateConditionCombinations(tableVariables: TableVariable[]) {
  // Create an array to hold the conditions with their titles
  const titledConditions: string[][] = []
  const titles: string[] = []

  // Iterate over each item in tableVariables
  for (const item of tableVariables) {
    // Initialize an empty array to hold the conditions for the current item
    const conditions: string[] = []
    titles.push(item.title) // Keep track of titles for later use

    // Iterate over each condition in the current item
    for (const condition of item.conditions) {
      // Add the title to the condition and push it to the conditions array
      if (item.continous === true)
        conditions.push(`${condition} ${item.unit}`)
      else
        conditions.push(`${condition}`)
    }

    // Add the conditions array for the current item to the titledConditions array
    titledConditions.push(conditions)
  }

  // Generate the Cartesian product of the titledConditions array
  const factors = cartesianProduct(titledConditions)

  // Initialize an empty array to hold the factor list
  const factorList: { [key: string]: string }[] = []

  // Iterate over each factor in the factors array
  for (const factor of factors) {
    // Initialize an object to hold the current combination
    const combinationObj: { [key: string]: string } = {}

    // Iterate over each item in the current factor
    for (let i = 0; i < factor.length; i++) {
      // Add a property to the object with the name being the title and the value being the condition
      combinationObj[titles[i]] = factor[i]
    }

    // Add the combination object to the factor list
    factorList.push(combinationObj)
  }

  // Return the factor list
  return factorList
}

function cartesianProduct(arr: Array<any>) {
  return arr.reduce((acc, val) => {
    return acc.map((el) => {
      return val.map((element) => {
        return el.concat([element])
      })
    }).reduce((acc, val) => acc.concat(val), [])
  }, [[]])
}
