<template>
  <v-app class="mx-auto">
    <layout-header></layout-header>
    <v-main>
      <v-container fluid>
        <v-card color="#FFFDE7" class="mx-auto">
          <router-view></router-view>
        </v-card>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import LayoutHeader from "../components/layout/LayoutHeader.vue";

import PostsIndexPage from "./posts/PostsIndexPage.vue";
import PostsNewPage from "./posts/PostsNewPage.vue";
import PostsEditPage from "./posts/PostsEditPage.vue";

import UsersIndexPage from "./users/UsersIndexPage.vue";
import UsersShowPage from "./users/UsersShowPage.vue";
import UsersEditPage from "./users/UsersEditPage.vue";
import UsersFollowingPage from "./users/UsersFollowingPage.vue";
import UsersFollowersPage from "./users/UsersFollowersPage.vue";

const router = new VueRouter({
  routes: [
    { path: "/", component: PostsIndexPage },
    { path: "/posts/new", name: "PostsNewPage", component: PostsNewPage },
    {
      path: "/posts/:id(\\d+)/edit",
      name: "PostsEditPage",
      component: PostsEditPage,
    },
    { path: "/users", name: "UsersIndexPage", component: UsersIndexPage },
    {
      path: "/users/:id(\\d+)",
      name: "UsersShowPage",
      component: UsersShowPage,
    },
    {
      path: "/users/:id(\\d+)/edit",
      name: "UsersEditPage",
      component: UsersEditPage,
    },
    {
      path: "/users/:id(\\d+)/following",
      name: "UsersFollowingPage",
      component: UsersFollowingPage,
    },
    {
      path: "/users/:id(\\d+)/followers",
      name: "UsersFollowersPage",
      component: UsersFollowersPage,
    },
  ],
});

Vue.use(VueRouter);

export default {
  components: { LayoutHeader },
  router,
  icons: {
    iconfont: "mdiSvg",
  },
};
</script>

<style scoped>
</style>

