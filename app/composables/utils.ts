import type { TableVariable, combinedVariable } from '@/types/wizard'

export function createTableEntries(Variables: TableVariable[], sampleType: string) {
  let entetyConditionCombinations = generateConditionCombinations(Variables)

  // Check if entetyConditionCombinations is an empty array
  if (!entetyConditionCombinations.length)
    return null

  entetyConditionCombinations = entetyConditionCombinations.map((combination) => {
    // Concatenate condition values to form secondaryName
    const concatName = combination.map(condition => Object.values(condition)[0]).join(' ; ')

    // Return the updated object
    return {
      conditions: combination,
      externalDBID: '',
      secondaryName: concatName,
      count: '1',
      sampleType,
    }
  })

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
  const factorList: { [key: string]: string }[][] = []

  // Iterate over each factor in the factors array
  for (const factor of factors) {
    // Initialize an array to hold the current combination
    const combinationArr: { [key: string]: string }[] = []

    // Iterate over each item in the current factor
    for (let i = 0; i < factor.length; i++) {
      // Create an object with the name being the title and the value being the condition
      const conditionObj = { [titles[i]]: factor[i] }
      // Add the object to the combination array
      combinationArr.push(conditionObj)
    }

    // Add the combination array to the factor list
    factorList.push(combinationArr)
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

export function crossProductSamples(parents: combinedVariable[], childs: combinedVariable[]) {
  console.log('🚀 ~ file: utils.ts:89 ~ crossProductSamples ~ childs:', childs)
  const result = []

  for (const parent of parents) {
    // Convert the parent's count to a number and check if it's higher than 1
    if (Number(parent.count) >= 1) {
      for (const child of childs) {
        const newEntry = JSON.parse(JSON.stringify(child)) // creating a deep copy
        newEntry.child = parent.secondaryName // set child attribute to secondaryName of entety
        newEntry.conditions.push(...parent.conditions) // combine conditions
        newEntry.secondaryName = `${parent.secondaryName} ; ${child.secondaryName}` // combine secondaryNames
        result.push(newEntry)
      }
    }
  }
  return result
}