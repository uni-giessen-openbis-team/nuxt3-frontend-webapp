<script setup>
import useOpenBisApi from '../composables/useOpenBisApi'

const { connect, disconnect, searchSpaces } = useOpenBisApi()

const fetchSpaces = async () => {
  try {
    await connect()
    const spaces = await searchSpaces()
    console.log('Spaces:', spaces)
    await disconnect()
  }
  catch (error) {
    console.error('Error:', error)
  }
}
</script>

<template>
  <button @click="fetchSpaces">
    Search Spaces
  </button>
</template>
In this example, I changed the name of the method in the component from searchSpaces to fetchSpaces to avoid the naming conflict.
