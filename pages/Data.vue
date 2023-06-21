<script setup>
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'



const store = useOpenBisStore()
const samples = ref([]) // This will hold your samples data
const spaces = ref([]) // This will hold your spaces data

onMounted(async () => {
  await store.loadV3API()
  samples.value = await store.searchSamples()
  spaces.value = await store.searchSpaces() // Fetch spaces
  //   projects.value = await store.searchProjects() // Fetch projects // TODO: does not work yet
})

const removeSample = (index) => {
  samples.value.splice(index, 1) // remove the sample at the specified index
  // Here you might want to add code to actually delete the sample from your backend
}
</script>

<template>
  <div>
    <h2>Display Samples</h2>
    <v-list two-line subheader class="border-list">
      <v-list-item>
        <v-row>
          <v-col>
            <v-list-item-content>
              <v-list-item-title><strong>Sample</strong></v-list-item-title>
            </v-list-item-content>
          </v-col>
          <v-col>
            <v-list-item-content>
              <v-list-item-title><strong>Code</strong></v-list-item-title>
            </v-list-item-content>
          </v-col>
          <v-col />
        </v-row>
      </v-list-item>
      <v-list-item v-for="(sample, index) in samples" :key="index">
        <v-row>
          <v-col>
            <v-list-item-content>
              <v-list-item-title>{{ sample }}</v-list-item-title>
            </v-list-item-content>
          </v-col>
          <v-col>
            <v-list-item-content>
              <v-list-item-title>{{ sample.code }}</v-list-item-title>
            </v-list-item-content>
          </v-col>
          <v-col>
            <v-list-item-content>
              <v-list-item-title>{{ sample["@type"] }}</v-list-item-title>
            </v-list-item-content>
          </v-col>
          <v-col>
            <v-list-item-action>
              <v-btn small color="error" @click="removeSample(index)">
                Remove
              </v-btn>
            </v-list-item-action>
          </v-col>
        </v-row>
      </v-list-item>
    </v-list>
  </div>

  <br>

  <v-btn color="primary" @click="createSample">
    Create Sample
  </v-btn>

  <h2>Display Spaces</h2>
  <v-list two-line subheader class="border-list">
    <v-list-item v-for="(space, index) in spaces" :key="index">
      <v-row>
        <v-col cols="11">
          <v-list-item-content>
            <v-list-item-title>{{ space }}</v-list-item-title> <!-- or space.someProperty -->
          </v-list-item-content>
        </v-col>
      </v-row>
    </v-list-item>
  </v-list>
</template>

<style scoped>
.border-list {
  border: 1px solid grey;
}
</style>
