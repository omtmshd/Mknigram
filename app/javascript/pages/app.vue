<template>
  <v-app>
    <layout-header></layout-header>
    <v-container id="display" fill-height fluid>
      <v-main>
        <router-view></router-view>
      </v-main>
    </v-container>
  </v-app>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";
import InfiniteLoading from "vue-infinite-loading";

import LayoutHeader from "../components/layout/LayoutHeader.vue";

import PostsFollowingPage from "./posts/PostsFollowingPage.vue";
import PostsCategoriesPage from "./posts/PostsCategoriesPage.vue";
import PostsLikesPage from "./posts/PostsLikesPage.vue";

import PostsNewPage from "./posts/PostsNewPage.vue";
import PostsEditPage from "./posts/PostsEditPage.vue";

import UsersIndexPage from "./users/UsersIndexPage.vue";
import UsersShowPage from "./users/UsersShowPage.vue";
import UsersEditPage from "./users/UsersEditPage.vue";

import LoginPage from "./login/LoginPage.vue";

const router = new VueRouter({
  routes: [
    { path: "/", component: PostsFollowingPage },
    {
      path: "/posts/:id(\\d+)/categories",
      name: "PostsCategoriesPage",
      component: PostsCategoriesPage,
    },
    {
      path: "/posts/likes",
      name: "PostsLikesPage",
      component: PostsLikesPage,
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
      path: "/sign_in",
      name: "LoginPage",
      component: LoginPage,
    },
  ],
});

Vue.use(VueRouter);
Vue.use(InfiniteLoading);

export default {
  components: { LayoutHeader },
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
#display {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}
</style>

