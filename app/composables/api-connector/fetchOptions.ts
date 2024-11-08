/**
 * Fetch options for openBIS
 * These fetch options specify the depth of the data to be fetched from the server.
 */
import { OuterExpressionKinds } from 'typescript';
import openbis from '../openbis.esm'

// Person fetch options
export function fetchPersonCompletely() {
    const options = new openbis.PersonFetchOptions();
    options.withRegistrator();
    options.withSpace();
    options.withRoleAssignments();
    return options;
}

export function fetchPersonWithSpace() {
    const options = new openbis.PersonFetchOptions();
    options.withSpaceUsing(fetchSpaceCompletely());
    return options;
}

// Role Assignment fetch options
export function fetchRoleAssignmentCompletely() {
    const options = new openbis.RoleAssignmentFetchOptions();
    options.withRegistrator();
    options.withSpace();
    options.withProject();
    options.withUser();
    options.withAuthorizationGroup();
    return options;
}

export function fetchRoleAssignmentWithUserAndAuthorizationGroupUsersCompletely() {
    const options = new openbis.RoleAssignmentFetchOptions();
    options.withRegistrator();
    options.withSpace();
    options.withProject();
    options.withUserUsing(fetchPersonCompletely());
    options.withAuthorizationGroupUsing(fetchAuthorizationGroupWithUsers());
    return options;
}

export function fetchRoleAssignmentWithSpaceAndUser() {
    const options = new openbis.RoleAssignmentFetchOptions();
    options.withSpaceUsing(fetchSpaceCompletely());
    options.withUserUsing(fetchPersonCompletely());
    return options;
}

export function fetchRoleAssignmentWithProjectAndUser() {
    const options = new openbis.RoleAssignmentFetchOptions();
    options.withProjectUsing(fetchProjectCompletely());
    options.withUserUsing(fetchPersonCompletely());
    return options;
}

// Authorization Group fetch options
export function fetchAuthorizationGroupCompletely() {
    const options = new openbis.AuthorizationGroupFetchOptions();
    options.withRegistrator();
    options.withRoleAssignments();
    options.withUsers();
    return options;
}

export function fetchAuthorizationGroupWithUsersCompletely() {
    const options = new openbis.AuthorizationGroupFetchOptions();
    options.withRegistrator();
    options.withRoleAssignments();
    options.withUsersUsing(fetchPersonCompletely());
    return options;
}

export function fetchAuthorizationGroupWithUsers() {
    const options = new openbis.AuthorizationGroupFetchOptions();
    options.withUsersUsing(fetchPersonCompletely());
    return options;
}

// Space fetch options
export function fetchSpaceCompletely() {
    const options = new openbis.SpaceFetchOptions();
    options.withRegistrator();
    options.withProjects();
    return options;
}

export function fetchSpaceWithProjectCompletely() {
    const options = new openbis.SpaceFetchOptions();
    options.withRegistrator();
    options.withProjectsUsing(fetchProjectCompletely());
    options.withSamples();
    return options;
}

// Project fetch options
export function fetchProjectCompletely() {
    const options = new openbis.ProjectFetchOptions();
    options.withRegistrator();
    options.withLeader();
    options.withSpace();
    options.withExperiments();
    options.withSamples();
    options.withAttachments();
    options.withHistory();
    options.withModifier();
    return options;
}

export function fetchProjectWithCollections() {
    const options = new openbis.ProjectFetchOptions();
    options.withRegistrator();
    options.withLeader();
    options.withSpace();
    options.withExperimentsUsing(fetchExperimentCompletely());
    options.withSamples();
    options.withAttachments();
    options.withHistory();
    options.withModifier();
    return options;
}

// Experiment fetch options
export function fetchExperimentCompletely() {
    const options = new openbis.ExperimentFetchOptions();
    options.withRegistrator();
    options.withProject();
    options.withSamples();
    options.withDataSets();
    options.withAttachments();
    options.withHistory();
    options.withModifier();
    options.withMaterialProperties();
    options.withProperties();
    options.withTags();
    options.withType();
    return options;
}

export function fetchCollectionWithProjectCompletely() {
    const options = new openbis.ExperimentFetchOptions();
    options.withRegistrator();
    options.withProjectUsing(fetchProjectCompletely());
    options.withSamples();
    options.withDataSets();
    options.withAttachments();
    options.withHistory();
    options.withModifier();
    options.withMaterialProperties();
    options.withProperties();
    options.withTags();
    options.withType();
    return options;
}

export function fetchCollectionTypeCompletely() {
    const options = new openbis.ExperimentTypeFetchOptions();
    options.withPropertyAssignments();
    options.withValidationPlugin();
    return options;
}

// Sample fetch options
export function fetchObjectCompletely() {
    const options = new openbis.SampleFetchOptions();
    options.withRegistrator();
    options.withSpace();
    options.withProject();
    options.withExperiment();
    options.withDataSets();
    options.withAttachments();
    options.withComponents();
    options.withContainer();
    options.withHistory();
    options.withModifier();
    options.withMaterialProperties();
    options.withProperties();
    options.withTags();
    options.withType();
    options.withParents();
    options.withChildren();
    return options;
}

export function fetchObjectWithParentsAndChildrenCompletely() {
    const options = new openbis.SampleFetchOptions();
    options.withRegistrator();
    options.withSpace();
    options.withProject();
    options.withExperiment();
    options.withDataSets();
    options.withAttachments();
    options.withComponents();
    options.withContainer();
    options.withHistory();
    options.withModifier();
    options.withMaterialProperties();
    options.withProperties();
    options.withTags();
    options.withType();
    options.withParentsUsing(fetchObjectCompletely());
    options.withChildrenUsing(fetchObjectCompletely());
    return options;
}

export function fetchObjectWithParentsAndChildrenRecursive() {
    const options = new openbis.SampleFetchOptions();
    options.withRegistrator();
    options.withSpace();
    options.withProject();
    options.withExperiment();
    options.withDataSets();
    options.withAttachments();
    options.withComponents();
    options.withContainer();
    options.withHistory();
    options.withModifier();
    options.withMaterialProperties();
    options.withProperties();
    options.withTags();
    options.withType();
    options.withParentsUsing(options);
    options.withChildrenUsing(options); 
    return options;
}

export function fetchObjectTypeCompletely() {
    const options = new openbis.SampleTypeFetchOptions();
    options.withPropertyAssignments();
    options.withSemanticAnnotations();
    options.withValidationPlugin();
    return options;
}

// DataSet fetch options
export function fetchDataSetCompletely() {
    const options = new openbis.DataSetFetchOptions();
    options.withRegistrator();
    options.withExperiment();
    options.withSample();
    options.withDataStore();
    options.withComponents();
    options.withContainers();
    options.withHistory();
    options.withModifier();
    options.withMaterialProperties();
    options.withProperties();
    options.withTags();
    options.withType();
    options.withLinkedData();
    options.withParents();
    options.withChildren();
    options.withPhysicalData();
    return options;
}

// Property Type fetch options
export function fetchPropertyTypeCompletely() {
    const options = new openbis.PropertyTypeFetchOptions();
    options.withRegistrator();
    options.withVocabulary();
    options.withSemanticAnnotations();
    options.withMaterialType();
    return options;
}

export function fetchPropertyTypeWithVocabularyAndTerms() {
    const options = new openbis.PropertyTypeFetchOptions();
    options.withVocabularyUsing(fetchVocabularyCompletely());
    return options;
}

// Property Assignment fetch options
export function fetchPropertyAssignmentCompletely() {
    const options = new openbis.PropertyAssignmentFetchOptions();
    options.withRegistrator();
    options.withPropertyType();
    options.withEntityType();
    options.withPlugin();
    return options;
}

export function fetchPropertyAssignmentWithPropertyType() {
    const options = new openbis.PropertyAssignmentFetchOptions();
    options.withPropertyTypeUsing(fetchPropertyTypeCompletely());
    return options;
}

// Material fetch options
export function fetchMaterialCompletely() {
    const options = new openbis.MaterialFetchOptions();
    options.withRegistrator();
    options.withHistory();
    options.withProperties();
    options.withMaterialProperties();
    options.withTags();
    options.withType();
    return options;
}

// Material Type fetch options
export function fetchMaterialTypeCompletely() {
    const options = new openbis.MaterialTypeFetchOptions();
    options.withPropertyAssignments();
    options.withValidationPlugin();
    return options;
}

// Vocabulary fetch options
export function fetchVocabularyCompletely() {
    const options = new openbis.VocabularyFetchOptions();
    options.withRegistrator();
    options.withTerms();
    return options;
}

// Vocabulary Term fetch options
export function fetchVocabularyTermCompletely() {
    const options = new openbis.VocabularyTermFetchOptions();
    options.withRegistrator();
    options.withVocabulary();
    return options;
}
