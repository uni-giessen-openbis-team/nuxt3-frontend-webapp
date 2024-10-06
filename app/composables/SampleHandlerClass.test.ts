// @vitest-environment nuxt
import { describe, it, expect, beforeEach } from 'vitest'
import { EntitySampleHandler, BiologicalSampleHandler, TechnicalSampleHandler } from './SampleHandlerClass'

describe('SampleHandler', () => {
  let entitySampleHandler: EntitySampleHandler
  let biologicalSampleHandler: BiologicalSampleHandler
  let technicalSampleHandler: TechnicalSampleHandler

  beforeEach(() => {
    entitySampleHandler = new EntitySampleHandler('SPACE_CODE', 'PROJECT_CODE', 'COLLECTION_ID')
    biologicalSampleHandler = new BiologicalSampleHandler('SPACE_CODE', 'PROJECT_CODE', 'COLLECTION_ID', entitySampleHandler)
    technicalSampleHandler = new TechnicalSampleHandler('SPACE_CODE', 'PROJECT_CODE', 'COLLECTION_ID', biologicalSampleHandler)
  })

  it('should create sample creations without parent', () => {
    const sampleCreations = entitySampleHandler.createSampleCreations()
    expect(sampleCreations).toHaveLength(entitySampleHandler.propertyCombinations.length)
  })

  it('should create sample creations with parent', () => {
    const sampleCreations = biologicalSampleHandler.createSampleCreations()
    expect(sampleCreations).toHaveLength(biologicalSampleHandler.propertyCombinations.length)
  })

  it('should create sample creations with grandparent', () => {
    const sampleCreations = technicalSampleHandler.createSampleCreations()
    expect(sampleCreations).toHaveLength(technicalSampleHandler.propertyCombinations.length)
  })

  it('should correctly combine properties from parent and child', () => {
    const sampleCreations = biologicalSampleHandler.createSampleCreations()
    sampleCreations.forEach(sample => {
      expect(sample.getProperties()).toMatchObject({
        'TISSUE_ID': expect.any(String),
        'name': expect.any(String),
      })
    })
  })

  it('should correctly combine properties from grandparent, parent, and child', () => {
    const sampleCreations = technicalSampleHandler.createSampleCreations()
    sampleCreations.forEach(sample => {
      expect(sample.getProperties()).toMatchObject({
        'TISSUE_ID': expect.any(String),
        'name': expect.any(String),
      })
    })
  })
})