<template>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input label="File input" multiple chips clearable hint="Select one or more files" persistent-hint />
        </v-form>
      </v-window-item>
   
</template>

<script>
export default {
    setup () {
        

        return {}
    }
}
</script>

<style lang="scss" scoped>

</style>