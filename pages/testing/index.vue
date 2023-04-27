//  OpenBIS api: http://bene-pc:3000/openbis/resources/api/v3/openbis.js
//  requirejs : http://bene-pc:3000/openbis/resources/api/v3/require.js
//  requirejs : http://bene-pc:3000/openbis/resources/api/v3/config.js
// SpaceSearchCriteria: http://bene-pc:3000/openbis/resources/api/v3/as/dto/space/search/SpaceSearchCriteria.js
// SpaceFetchOptions: http://bene-pc:3000/openbis/resources/api/v3/as/dto/space/fetchoptions/SpaceFetchOptions.js

<script setup>
import openbisAdapter from '../../composables/openbisAdapter';

(async () => {
  try {
    // Login
    const v3 = await openbisAdapter.login('admin', 'password')
    // Search for spaces
    const spaces = await openbisAdapter.searchSpaces(v3)
    console.log(`Number of spaces: ${spaces.length}`)

    // Logout
    await openbisAdapter.logout(v3)
  }
  catch (error) {
    console.error('Error:', error)
  }
})()
</script>

 <template>
  <div>Number of spaces: {{ numberOfSpaces }}</div>
</template>
