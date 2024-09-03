import  openbis from "../openbis.esm"

async function listVocabularies(criteria: openbis.VocabularySearchCriteria, options: openbis.VocabularyFetchOptions): Promise<openbis.Vocabulary[] | undefined> {
  const result = await useOpenBisStore().v3?.searchVocabularies(criteria, options)
  return result?.getObjects() || []
}

async function listAllVocabularies(): Promise<openbis.Vocabulary[]> {
  const searchResults = await listVocabularies(new openbis.VocabularySearchCriteria(), fetchVocabularyCompletely())
  return searchResults || []
}

async function getVocabulary(vocabularyId: openbis.IVocabularyId, options: openbis.VocabularyFetchOptions): Promise<openbis.Vocabulary | undefined> {
  const result = await useOpenBisStore().v3?.getVocabularies([vocabularyId], options)
  return result ? result[0] : undefined
}

async function getVocabularyById(vocabularyId: openbis.IVocabularyId): Promise<openbis.Vocabulary | undefined> {
  return getVocabulary(vocabularyId, fetchVocabularyCompletely())
}

async function getVocabulariesByCodes(vocabularyCodes: string[]): Promise<Map<openbis.IVocabularyId, openbis.Vocabulary>> {
  const vocabularyIds = vocabularyCodes.map(code => new openbis.VocabularyPermId(code))
  const result = await useOpenBisStore().v3?.getVocabularies(vocabularyIds, fetchVocabularyCompletely())
  return result || new Map()
}

async function listVocabularyTerms(criteria: openbis.VocabularyTermSearchCriteria, options: openbis.VocabularyTermFetchOptions): Promise<openbis.VocabularyTerm[]> {
  const result = await useOpenBisStore().v3?.searchVocabularyTerms(criteria, options)
  return result?.getObjects() || []
}

async function listAllVocabularyTerms(): Promise<openbis.VocabularyTerm[]> {
  return listVocabularyTerms(new openbis.VocabularyTermSearchCriteria(), fetchVocabularyTermCompletely())
}

async function listVocabularyTermsByVocabularyId(vocabularyId: string): Promise<openbis.VocabularyTerm[]> {
  const criteria = new openbis.VocabularyTermSearchCriteria()
  criteria.withVocabulary().withId().thatEquals(vocabularyId)
  return listVocabularyTerms(criteria, fetchVocabularyTermCompletely())
}

async function listVocabularyTermsByVocabularyCode(vocabularyCode: string): Promise<openbis.VocabularyTerm[]> {
  const criteria = new openbis.VocabularyTermSearchCriteria()
  criteria.withVocabulary().withCode().thatEquals(vocabularyCode)
  return listVocabularyTerms(criteria, fetchVocabularyTermCompletely())
}

async function getVocabularyTerm(vocabularyTermId: openbis.IVocabularyTermId, options?: openbis.VocabularyTermFetchOptions): Promise<string | undefined> {
  const result = await useOpenBisStore().v3?.getVocabularyTerms([vocabularyTermId], options)
  return  result?.get(vocabularyTermId) || undefined 
}

async function getVocabularyTermById(vocabularyTermId: openbis.IVocabularyTermId): Promise<openbis.VocabularyTerm | undefined> {
  return getVocabularyTerm(vocabularyTermId, fetchVocabularyTermCompletely())
}

async function getVocabularyTermByCode(vocabularyTermCode: string, vocabularyCode: string): Promise<openbis.VocabularyTerm | undefined> {
  return getVocabularyTerm(
    new openbis.VocabularyTermPermId(vocabularyTermCode, vocabularyCode),
    fetchVocabularyTermCompletely(),
  )
}

async function getVocabularyTermsByCodes(vocabularyTermIds: Map<string, string>): Promise<Map<openbis.IVocabularyTermId, openbis.VocabularyTerm>> {
  const vocabularyTermIdList = Array.from(vocabularyTermIds, ([key, value]) => new openbis.VocabularyTermPermId(key, value))
  const result = await useOpenBisStore().v3?.getVocabularyTerms(vocabularyTermIdList, fetchVocabularyTermCompletely())
  return result || new Map()
}

async function createVocabularyTerm(creation: openbis.VocabularyTermCreation): Promise<openbis.IVocabularyTermId | undefined> {
  const result = await useOpenBisStore().v3?.createVocabularyTerms([creation])
  return result ? result[0] : undefined
}

async function createVocabularyTermByVocabulary(vocabularyId: openbis.IVocabularyId, code: string, label?: string, description?: string): Promise<openbis.IVocabularyTermId | undefined> {
  const creation = new openbis.VocabularyTermCreation()
  creation.setVocabularyId(vocabularyId)
  creation.setCode(code)
  creation.setLabel(label)
  creation.setDescription(description)
  return createVocabularyTerm(creation)
}

async function updateVocabularyTerm(update: openbis.VocabularyTermUpdate): Promise<boolean> {
  try {
    await useOpenBisStore().v3?.updateVocabularyTerms([update])
    return true
  } catch (error) {
    console.error(`${error.constructor.name}: ${error.message}`)
    console.warn(`updateVocabularyTerm failed with update ${update}, returned false.`)
    return false
  }
}

async function updateVocabularyTermLabel(vocabularyTermId: openbis.IVocabularyTermId, label: string): Promise<boolean> {
  const update = new openbis.VocabularyTermUpdate()
  update.setVocabularyTermId(vocabularyTermId)
  update.setLabel(label)
  return updateVocabularyTerm(update)
}

async function getVocabularyTerms(vocabularyTermIds: openbis.IVocabularyTermId[]): Promise<Map<openbis.IVocabularyTermId, openbis.VocabularyTerm> | undefined> {
  const result = await useOpenBisStore().v3?.getVocabularyTerms(vocabularyTermIds, fetchVocabularyTermCompletely())
  return result
}

export {
  listVocabularies,
  listAllVocabularies,
  getVocabulary,
  getVocabularyById,
  getVocabulariesByCodes,
  listVocabularyTerms,
  listAllVocabularyTerms,
  listVocabularyTermsByVocabularyId,
  listVocabularyTermsByVocabularyCode,
  getVocabularyTerm,
  getVocabularyTermById,
  getVocabularyTermByCode,
  getVocabularyTermsByCodes,
  createVocabularyTerm,
  createVocabularyTermByVocabulary,
  updateVocabularyTerm,
  updateVocabularyTermLabel,
  getVocabularyTerms
}
