<template>
  <v-app id="display">
    <layout-header></layout-header>
    <v-container class="mx-auto" fill-height>
      <v-row justify="center">
        <v-col cols="12">
          <v-main>
            <router-view></router-view>
          </v-main>
        </v-col>
      </v-row>
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

import PostsNewPage from "./posts/PostsNewPage.vue";
import PostsEditPage from "./posts/PostsEditPage.vue";

import UsersIndexPage from "./users/UsersIndexPage.vue";
import UsersShowPage from "./users/UsersShowPage.vue";
import UsersEditPage from "./users/UsersEditPage.vue";

import LoginPage from "./login/LoginPage.vue";
import SignUpPage from "./login/SignUpPage.vue";

const router = new VueRouter({
  routes: [
    { path: "/", component: PostsFollowingPage },
    {
      path: "/posts/:id(\\d+)/categories",
      name: "PostsCategoriesPage",
      component: PostsCategoriesPage,
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
    {
      path: "/sign_up",
      name: "SignUpPage",
      component: SignUpPage,
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
}
</style>

