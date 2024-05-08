import { defineStore } from 'pinia'
import  openbis  from '@bschwab/types-api-openbis';


export const useVocabularyStore = defineStore('vocabulary', {
    state:() => ({
        
    }),
    actions: {
      // works
      async listVocabularies(criteria?: VocabularySearchCriteria, options?: VocabularyFetchOptions): Vocabulary[] {
              const result = await useOpenBisStore().v3.searchVocabularies(criteria, options)
              return result.objects
      },

      // works
      listAllVocabularies(): Vocabulary[] {
          return this.listVocabularies(new openbis.VocabularySearchCriteria(), fetchVocabularyCompletely())
      },

      async getVocabulary(vocabularyId: IVocabularyId, options?: VocabularyFetchOptions): Vocabulary {
        const result = await useOpenBisStore().v3.getVocabularies([vocabularyId], options)
        return result.get(vocabularyId)
      },

      getVocabularyById(vocabularyId: IVocabularyId): Vocabulary {

        return this.getVocabulary(vocabularyId, this.fetchVocabularyCompletely())
      },

      getVocabularyByCode(vocabularyCode: string): Vocabulary {

        return this.getVocabulary(new VocabularyPermId(vocabularyCode), this.fetchVocabularyCompletely())
      },

      getVocabulariesByCodes(vocabularyCodes: string[]): Map<IVocabularyId, Vocabulary> {

        const vocabularyIds = vocabularyCodes.map(code => new VocabularyPermId(code))
        return useOpenBisStore().v3.getVocabularies(vocabularyIds, this.fetchVocabularyCompletely())
      },



      /* ----------------------------------------------------------------------------------------- */
      /* ----- VocabularyTerm API Methods -------------------------------------------------------- */
      /* ----------------------------------------------------------------------------------------- */

      listVocabularyTerms(criteria?: VocabularyTermSearchCriteria, options?: VocabularyTermFetchOptions): VocabularyTerm[] {

        const result = useOpenBisStore().v3.searchVocabularyTerms(criteria, options)
        return result.getObjects()
      },

      listAllVocabularyTerms(): VocabularyTerm[] {

        return this.listVocabularyTerms(new VocabularyTermSearchCriteria(), this.fetchVocabularyTermCompletely())
      },

      listVocabularyTermsByVocabularyId(vocabularyId: IVocabularyId): VocabularyTerm[] {

        const criteria = new VocabularyTermSearchCriteria().withVocabulary().withId().thatEquals(vocabularyId)
        return this.listVocabularyTerms(criteria)
      },

      listVocabularyTermsByVocabularyCode(vocabularyCode: string): VocabularyTerm[] {

        const criteria = new VocabularyTermSearchCriteria().withVocabulary().withCode().thatEquals(vocabularyCode)
        return this.listVocabularyTerms(criteria)
      },

      listVocabularyTermsByProperty(property: PropertyType): VocabularyTerm[] {
        try {
          const fullProperty = useOpenBisStore().v3.getPropertyTypes(
            List.of(property.getPermId()),
            this.fetchPropertyTypeWithVocabularyAndTerms(),
          ).get(property.getPermId())

          if (fullProperty === null)
            throw new IllegalArgumentException(`PropertyType ${property.getCode()} does not exist.`)

          return fullProperty.getVocabulary().getTerms()
        }
        catch (error) {
          logger.error(`${error.constructor.name}: ${error.message}`)
          logger.warn(`listVocabularyTerms(<TOKEN>,${property}) failed and returned an empty list.`)
          return []
        }
      },

      getVocabularyTerm(vocabularyTermId: IVocabularyTermId, options?: VocabularyTermFetchOptions): VocabularyTerm {

        const result = useOpenBisStore().v3.getVocabularyTerms([vocabularyTermId], options)
        return result.get(vocabularyTermId)
      },

      getVocabularyTermById(vocabularyTermId: IVocabularyTermId): VocabularyTerm {

        return this.getVocabularyTerm(vocabularyTermId, this.fetchVocabularyTermCompletely())
      },

      getVocabularyTermByCode(vocabularyTermCode: string, vocabularyCode: string): VocabularyTerm {

        return this.getVocabularyTerm(
          new VocabularyTermPermId(vocabularyTermCode, vocabularyCode),
          this.fetchVocabularyTermCompletely(),
        )
      },

      getVocabularyTermsByCodes(vocabularyTermIds: Map<string, string>): Map<IVocabularyTermId, VocabularyTerm> {

        const vocabularyTermIdList = Array.from(vocabularyTermIds, ([key, value]) => new VocabularyTermPermId(key, value))
        return this.getVocabularyTerms(vocabularyTermIdList)
      },

      createVocabularyTerm(creation: VocabularyTermCreation): IVocabularyTermId {
        return useOpenBisStore().v3.createVocabularyTerms([creation])[0]
      },

      // answer from email. How create VocabTerms

      // var creation = new VocabularyTermCreation();
      // creation.setVocabularyId(new VocabularyPermId("MY_VOCABULARY_CODE"));
      // creation.setCode("MY_TERM_CODE");
      // creation.setLabel("My term label");
      // creation.setDescription("My term description");

      // v3.createVocabularyTerms([ creation ]).done(function(result) {
      //     alert("Created term: " + result[0]);
      // }).fail(function(error){
      //     alert("Something went wrong: " + JSON.stringify(error))
      // });

      createVocabularyTermByVocabulary(vocabularyId: IVocabularyId, code: string, label?: string, description?: string): IVocabularyTermId {

        const creation = new VocabularyTermCreation()
        creation.setVocabularyId(vocabularyId)
        creation.setCode(code)
        creation.setLabel(label)
        creation.setDescription(description)

        return this.createVocabularyTerm(creation)
      },

      updateVocabularyTerm(update: VocabularyTermUpdate): boolean {

        try {
          useOpenBisStore().v3.updateVocabularyTerms([update])
          return true
        }
        catch (error) {
          logger.error(`${error.constructor.name}: ${error.message}`)
          logger.warn(`updateVocabularyTerm(<TOKEN>,${update}) failed and returned null.`)
          return false
        }
      },

      updateVocabularyTermLabel(vocabularyTermId: IVocabularyTermId, label: string): boolean {

        const update = new VocabularyTermUpdate()
        update.setVocabularyTermId(vocabularyTermId)
        update.setLabel(label)

        return this.updateVocabularyTerm(update)
      },


      // Vocabulary code is something like "SPECIES"
      async getVocabularyTerms(vocabularyTermIds: IVocabularyTermId[]): Map<IVocabularyTermId, VocabularyTerm> {
        const VocabularyTerms = await useOpenBisStore().v3.getVocabularyTerms(vocabularyTermIds, this.fetchVocabularyTermCompletely())
        return VocabularyTerms
      },

      // One space for each working group
      async getAllSpaces(): Promise<Space[]> {
        const criteria = new SpaceSearchCriteria()
        const fo = new SpaceFetchOptions()
        return await this.searchSpaces(criteria, fo)
      },

      prepareProjectCreation(projectCode, spaceCode, description = null) {

        const creation = new ProjectCreation()
        creation.setCode(projectCode)
        creation.setSpaceId(new SpacePermId(spaceCode))

        if (description)
          creation.setDescription(description)

        return creation
      },

      async createProject(projectCode, spaceCode, description) {
        const creation = await this.prepareProjectCreation(projectCode, spaceCode, description)
        return await useOpenBisStore().v3.createProjects(creation)
      },

      // The main function
      // pass the sampleGroups in the right order. From top to bottom hiracy
      async createSamplesFromWizzard(projectContext, sampleGroups) {

        const createdSamples = []
        const sampleCreationsDict = {}

        for (const sampleList of sampleGroups) {
          for (const sample of sampleList) {
            const sampleCreation = new SampleCreation()
            sampleCreation.setTypeId(new EntityTypePermId(sample.sampleType))
            sampleCreation.setSpaceId(new SpacePermId(projectContext.space))
            sampleCreation.setCreationId(new CreationId(sample.secondaryName))

            // Iterate over conditions and set property for each
            for (const condition of sample.conditions) {
              for (const [key, value] of Object.entries(condition))
                sampleCreation.setProperty(key, value)
            }
            // sampleCreation.setCode('MY_SAMPLE_CODE')
            // sampleCreation.setExperimentId(new ExperimentIdentifier('/MY_SPACE_CODE/MY_PROJECT_CODE/MY_EXPERIMENT_CODE'))

            if (sample.parent) {
              // If the sample has a parent, directly get the parent's SampleCreation object from the dictionary
              const parentSampleCreation = sampleCreationsDict[sample.parent]
              if (parentSampleCreation) {
                sampleCreation.setParentIds([parentSampleCreation.getCreationId()])

                // Add the sample's creation ID to the parent's child IDs
                const parentChildIds = parentSampleCreation.getChildIds() || []
                parentChildIds.push(sampleCreation.getCreationId())
                parentSampleCreation.setChildIds(parentChildIds)
              }
              else { console.log('Parent sample not found') }
            }

            sample.sampleCreation = sampleCreation
            // Add the SampleCreation object to the dictionary
            sampleCreationsDict[sample.secondaryName] = sampleCreation
            createdSamples.push(sampleCreation)
          }
        }

        return await useOpenBisStore().v3.createSamples([createdSamples[0]]).done((permIds) => {
          alert(`Perm ids: ${JSON.stringify(permIds)}`)
        })
        // return createdSamples
      },
    }
})
   