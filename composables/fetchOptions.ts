import  openbis  from '@bschwab/types-api-openbis';

/*  
    This is a collection of fetch options for openBis\
    The fetch options are used to specify what data should be fetched from the server
    when a request is made. The options are used to specify the depth of the data to be fetched
    and the data to be fetched.  
*/

// person
export function fetchPersonCompletely() {
    const options = new openbis.PersonFetchOptions()
    options.withRegistrator()
    options.withSpace()
    options.withRoleAssignments()
    return options
    }

    export function fetchPersonWithSpace() {
    const options = new openbis.PersonFetchOptions()
    options.withSpaceUsing(fetchSpaceCompletely())
    return options
    }


  // Role Assighnment
    export function fetchRoleAssignmentCompletely() {
    const options = new openbis.RoleAssignmentFetchOptions()
    options.withRegistrator()
    options.withSpace()
    options.withProject()
    options.withUser()
    options.withAuthorizationGroup()
    return options
    }


    export function fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely() {
    const options = new openbis.RoleAssignmentFetchOptions()
    options.withRegistrator()
    options.withSpace()
    options.withProject()
    options.withUserUsing(fetchPersonCompletely())
    options.withAuthorizationGroupUsing(fetchAuthorizationGroupWithUsers())
    return options
    }

  export function fetchRoleAssignmentWithSpaceAndUser() {
    const options = new openbis.RoleAssignmentFetchOptions()
    options.withSpaceUsing(fetchSpaceCompletely())
    options.withUserUsing(fetchPersonCompletely())
  return options
  }

    export function fetchRoleAssignmentWithProjectAndUser() {
    const options = new openbis.RoleAssignmentFetchOptions()
    options.withProjectUsing(fetchProjectCompletely())
    options.withUserUsing(fetchPersonCompletely())
    return options
    }

    export function fetchAuthorizationGroupCompletely() {
    const options = new openbis.AuthorizationGroupFetchOptions()
    options.withRegistrator()
    options.withRoleAssignments()
    options.withUsers()
    return options
    }

    export function fetchAuthorizationGroupWithUsersCompletely() {
    const options = new openbis.AuthorizationGroupFetchOptions()
    options.withRegistrator()
    options.withRoleAssignments()
    options.withUsersUsing(fetchPersonCompletely())
    return options
    }

    export function fetchAuthorizationGroupWithUsers() {
    const options = new openbis.AuthorizationGroupFetchOptions()
    options.withUsersUsing(fetchPersonCompletely())
    return options
    }

    export function  fetchSpaceCompletely() {
        const options = new openbis.SpaceFetchOptions()
        options.withRegistrator()
        options.withProjects()
        options.withSamples()
        return options
      }

      export function fetchSpaceWithProjectCompletely() {
        const options = new openbis.SpaceFetchOptions()
        options.withRegistrator()
        options.withProjectsUsing(fetchProjectCompletely())
        options.withSamples()
        return options
      }

    //  Project 
    export function fetchProjectCompletely() {
        const options = new openbis.ProjectFetchOptions()
        options.withRegistrator()
        options.withLeader()
        options.withSpace()
        options.withExperiments()
        options.withSamples()
        options.withAttachments()
        options.withHistory()
        options.withModifier()
        return options
      }

      export function fetchProjectWithCollections() {
        const options = openbis.ProjectFetchOptions()
        options.withRegistrator()
        options.withLeader()
        options.withSpace()
        options.withExperimentsUsing(fetchExperimentCompletely())
        options.withSamples()
        options.withAttachments()
        options.withHistory()
        options.withModifier()
        return options
      }


      export function  fetchExperimentCompletely() {
        const options = new openbis.ExperimentFetchOptions()
        options.withRegistrator()
        options.withProject()
        options.withSamples()
        options.withDataSets()
        options.withAttachments()
        options.withHistory()
        options.withModifier()
        options.withMaterialProperties()
        options.withProperties()
        options.withTags()
        options.withType()
        return options
      }

      export function   fetchCollectionWithProjectCompletely() {
        const options = new openbis.ExperimentFetchOptions()
        options.withRegistrator()
        options.withProjectUsing(fetchProjectCompletely())
        options.withSamples()
        options.withDataSets()
        options.withAttachments()
        options.withHistory()
        options.withModifier()
        options.withMaterialProperties()
        options.withProperties()
        options.withTags()
        options.withType()
        return options
      }

      export function   fetchCollectionTypeCompletely() {
        const options = new openbis.ExperimentTypeFetchOptions()
        options.withPropertyAssignments()
        options.withValidationPlugin()
        return options
      }


      export function fetchVocabularyCompletely() {
        const options = new openbis.VocabularyFetchOptions()
        options.withRegistrator()
        options.withTerms()
        return options
      }

      export function fetchVocabularyTermCompletely() {
        const options = new openbis.VocabularyTermFetchOptions()
        options.withRegistrator()
        options.withVocabulary()
        return options
      }


      export function  fetchObjectCompletely() {
        const options = new openbis.SampleFetchOptions()
        options.withRegistrator()
        options.withSpace()
        options.withProject()
        options.withExperiment()
        options.withDataSets()
        options.withAttachments()
        options.withComponents()
        options.withContainer()
        options.withHistory()
        options.withModifier()
        options.withMaterialProperties()
        options.withProperties()
        options.withTags()
        options.withType()
        options.withParents()
        options.withChildren()
        // options.withSampleProperties();  // ?
        return options
      }

      export function fetchObjectWithParentsAndChildrenCompletely() {
        const options = new openbis.SampleFetchOptions()
        options.withRegistrator()
        options.withSpace()
        options.withProject()
        options.withExperiment()
        options.withDataSets()
        options.withAttachments()
        options.withComponents()
        options.withContainer()
        options.withHistory()
        options.withModifier()
        options.withMaterialProperties()
        options.withProperties()
        options.withTags()
        options.withType()
        options.withParentsUsing(fetchObjectCompletely())
        options.withChildrenUsing(fetchObjectCompletely())
        // options.withSampleProperties();  // ?
        return options
      }

      export function  fetchObjectWithParentsAndChildrenRecursive() {
        const options = openbis.SampleFetchOptions()
        options.withRegistrator()
        options.withSpace()
        options.withProject()
        options.withExperiment()
        options.withDataSets()
        options.withAttachments()
        options.withComponents()
        options.withContainer()
        options.withHistory()
        options.withModifier()
        options.withMaterialProperties()
        options.withProperties()
        options.withTags()
        options.withType()
        options.withParentsUsing(options)
        options.withChildrenUsing(options)
        // options.withSampleProperties();  // ?
        return options
      }

      export function  fetchObjectTypeCompletely() {
        const options = new openbis.SampleTypeFetchOptions()
        options.withPropertyAssignments()
        options.withSemanticAnnotations()
        options.withValidationPlugin()
        return options
      }
      