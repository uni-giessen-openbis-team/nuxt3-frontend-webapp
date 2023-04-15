<script setup lang="ts">
// import { useTheme } from 'vuetify'

const openBizDescription = [
  {
    header: 'Store your data',
    text: 'With openBIS+, you can store all your experimental research data in one central location. Data protection compliant. Your data is encrypted from the moment of upload and can only be read by people who explicitly have been granted access.',
    link: '/data-storage',
  },
  {
    header: 'Analyse your data',
    text: 'Analyze your Omics data reproducibly and with little effort. openBIS+ is directly connected to a workflow registry that provides standardized analysis pipelines. These pipelines are firmly versioned with all their used tools and therefore always generate the same results with the same input.',
    link: '/workflows',
  },
  {
    header: 'View your data',
    text: 'Preview project related data or the results of your analysis directly in your browser at any time and at any place.',
    link: '/projects',
  },
  {
    header: 'Share your data',
    text: '... Coming Soon ..',
    link: '/data-storage/share-data',
  },

]
</script>

<template>
  <v-container>
    <h1>
      Welcome
    </h1>

    <h2>BCF openBIS+ Instance</h2>
  </v-container>

  <v-divider />

  <v-container v-for="item in openBizDescription" :key="item.header">
    <v-card>
      <v-card-title>{{ item.header }}</v-card-title>

      <v-card-text>{{ item.text }}</v-card-text>
    </v-card>
  </v-container>
  <v-container>
    <div>
      This service is part of the Bioinformatics Core Facility (BCF) which provides a centralized IT-infrastructure for high-throughput data analysis.
    </div>
  </v-container>
</template>

<style scoped>

</style>
