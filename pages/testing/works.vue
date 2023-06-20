<script setup>
import { onMounted } from 'vue'


const resourcesToLoad = [
  'openbis',
  'as/dto/space/search/SpaceSearchCriteria',
  'as/dto/space/fetchoptions/SpaceFetchOptions',
]

const loadedResources = shallowRef({})

async function loadV3API() {
  const promises = resourcesToLoad.map((fullName) => {
    return new Promise((resolve) => {
      require([fullName], (resource) => {
        const shortName = fullName.includes('/') ? fullName.substring(fullName.lastIndexOf('/') + 1) : fullName
        loadedResources.value[shortName] = resource
        console.log(loadedResources.value)
      },
      )
    })
  })
  await Promise.all(promises)
}

function useV3API() {
  const openbis = new loadedResources.value.openbis()
  const criteria = new loadedResources.value.SpaceSearchCriteria()
  const fo = new loadedResources.value.SpaceFetchOptions()

  openbis.login('admin', 'changeit').done(() => {
    openbis.searchSpaces(criteria, fo).done((result) => {
      alert(`Loaded spaces: ${result.objects.length}`)
    })
  })
}

onMounted(() => {
  loadV3API()
})
</script>

<template>
  <div>
    <button @click="loadV3API">
      Load V3 API
    </button>
    <button @click="useV3API">
      Use V3 API
    </button>
  </div>
</template>
