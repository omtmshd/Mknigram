<template>
  <v-app id="app">
    <router-view></router-view>
  </v-app>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import PostsIndexPage from "./posts/PostsIndexPage.vue";
import PostsShowPage from "./posts/PostsShowPage.vue";
import PostsNewPage from "./posts/PostsNewPage.vue";
import PostsEditPage from "./posts/PostsEditPage.vue";

import UsersIndexPage from "./users/UsersIndexPage.vue";
import UsersShowPage from "./users/UsersShowPage.vue";
import UsersEditPage from "./users/UsersEditPage.vue";
import UsersFollowingPage from "./users/UsersFollowingPage.vue";
import UsersFollowersPage from "./users/UsersFollowersPage.vue";
import { currentUser } from "../packs/mixins/currentUser";
const router = new VueRouter({
  routes: [
    { path: "/", component: PostsIndexPage },
    {
      path: "/posts/:id(\\d+)",
      name: "PostsShowPage",
      component: PostsShowPage,
    },
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
Vue.mixin(currentUser);

export default {
  router,
};
</script>

<style scoped>
</style>
