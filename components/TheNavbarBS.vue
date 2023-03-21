<script setup>
import { ref } from 'vue'

const pageRoutes = [
  { name: 'Home', icon: 'mdi-home', path: '/' },
  { name: 'Workflows', icon: 'mdi-home', path: '/workflows' },
  { name: 'About', icon: 'mdi-information', path: '/about' },
  { name: 'Contact', icon: 'mdi-email', path: '/contact' },
]

const isCollapsed = ref(true)

const settings = [
  { name: 'Settings', icon: 'mdi-cog', path: '/settings' },
]
</script>

<template>
  <v-container>
    <v-app-bar app color="primary" dark>
      <v-app-bar-nav-icon>
        <v-icon icon="mdi-vuetify" />
      </v-app-bar-nav-icon>
      <nuxt-link :to="pageRoutes[0].path" class="text-decoration-none">
        <v-img src="logo.png" class="bg-white rounded" max-height="40" max-width="40" />
      </nuxt-link>
      <v-spacer />
      <!-- Drawer hat the side of the page  -->
      <v-navigation-drawer v-model="isCollapsed" app>
        <v-list>
          <v-list-item v-for="routeItem in pageRoutes" :key="routeItem.name">
            <nuxt-link :to="routeItem.path" class="text-decoration-none">
              <v-list-item-icon>
                <v-icon>{{ routeItem.icon }}</v-icon>
              </v-list-item-icon>
              <v-list-item-content>{{ routeItem.name }}</v-list-item-content>
            </nuxt-link>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>
      <v-btn icon>
        <nuxt-link :to="settings[0].path">
          <v-icon>{{ settings[0].icon }}</v-icon>
        </nuxt-link>
      </v-btn>
    </v-app-bar>
    <nuxt />
  </v-container>
</template>
