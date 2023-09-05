<script>
// local registration
import { FormWizard, TabContent } from 'vue3-form-wizard'
import 'vue3-form-wizard/dist/style.css'
export default {
  // component code
  components: {
    FormWizard,
    TabContent,
  },
  methods: {
    onComplete() {
      alert('Yay. Done!')
    },
  },
}
</script>

<template>
  <v-window v-model="tab">
    <v-form>
      <FormWizard color="#094899" @on-complete="onComplete">
        <TabContent title="Personal details" icon="fa fa-angle-down">
          My first tab content
        </TabContent>
        <TabContent title="Additional Info" icon="fa fa-gear">
          My second tab content
        </TabContent>

        <TabContent title="Last step" icon="fa fa-city">
          Yuhuuu! This seems pretty damn simple
        </TabContent>
      </FormWizard>
    </v-form>
  </v-window>
</template>

<style>
@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css");
</style>
