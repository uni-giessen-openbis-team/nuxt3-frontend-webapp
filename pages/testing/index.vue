//  OpenBIS api: http://bene-pc:3000/openbis/resources/api/v3/openbis.js
//  requirejs : http://bene-pc:3000/openbis/resources/api/v3/require.js
//  requirejs : http://bene-pc:3000/openbis/resources/api/v3/config.js
// SpaceSearchCriteria: http://bene-pc:3000/openbis/resources/api/v3/as/dto/space/search/SpaceSearchCriteria.js
// SpaceFetchOptions: http://bene-pc:3000/openbis/resources/api/v3/as/dto/space/fetchoptions/SpaceFetchOptions.js

<script>
// With "require" call we asynchronously load "openbis", "SpaceSearchCriteria" and "SpaceFetchOptions" classes that we will need for our example.
// The function that is passed as a second parameter of the require call is a callback that gets executed once requested classes are loaded.
// In Javascript we work with exactly the same classes as in Java. For instance, "ch.ethz.sis.openbis.generic.asapi.v3.dto.space.search.SpaceSearchCriteria"
// Java class and "as/dto/space/search/SpaceSearchCriteria" Javascript class have exactly the same methods. In order to find a Javascript class name please
// check our Javadoc (https://openbis.ch/javadoc/20.10.x/javadoc-api-v3/index.html). The Javascript class name is defined in @JsonObject annotation of each V3 API Java DTO.

require(['openbis', 'as/dto/space/search/SpaceSearchCriteria', 'as/dto/space/fetchoptions/SpaceFetchOptions'], (openbis, SpaceSearchCriteria, SpaceFetchOptions) => {
  // get a reference to AS API
  const v3 = new openbis()

  // login to obtain a session token (the token it is automatically stored in openbis object and will be used for all subsequent API calls)
  // v3.login('admin', 'password').done(() => {
  // invoke other API methods, for instance search for spaces
  v3.searchSpaces(new SpaceSearchCriteria(), new SpaceFetchOptions()).done((result) => {
    alert(`Number of spaces: ${result.getObjects().length}`)

    // logout to release the resources related with the session
    // v3.logout()
    // })
  })
})
</script>

<template>
  test
</template>
