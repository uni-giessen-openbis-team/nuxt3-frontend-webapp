<script>
const footerLinks = [{
  name: 'Impressum',
}, {
  name: 'Privacy information',
}]
</script>

<template>
  <v-footer app absolute width="auto" color="tertiary">
    <v-container>
      <v-col>
        <v-row>
          Phasellus feugiat arcu sapien, et iaculis ipsum elementum sit amet. Mauris cursus commodo interdum. Praesent ut risus eget metus luctus accumsan id ultrices nunc.
        </v-row>
        <v-divider />
        <v-row>
          <v-col>
            <TheDarkToggle />
          </v-col>
          <v-col>
            {{ new Date().getFullYear() }} — <strong>OpenBiz Team</strong>
          </v-col>
        </v-row>
      </v-col>
    </v-container>
  </v-footer>
</template>
