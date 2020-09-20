<template>
  <v-app>
    <v-container fill-height fluid>
      <v-main>
        <router-view></router-view>
      </v-main>
    </v-container>
  </v-app>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import AdminUsersIndex from "./AdminUsersIndex.vue";
import AdminUsersShow from "./AdminUsersShow.vue";

const router = new VueRouter({
  routes: [
    { path: "/", component: AdminUsersIndex },
    {
      path: "/users/:id(\\d+)",
      component: AdminUsersShow,
      name: AdminUsersShow,
    },
  ],
});

Vue.use(VueRouter);

export default {
  router,
};
</script>

<style scoped>
.container {
  padding: 0;
}
.col-12 {
  padding: 0;
}
</style>

