<template>
  <div>
    <router-view></router-view>
  </div>
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
  ],
});

Vue.use(VueRouter);

export default {
  router,
};
</script>

<style scoped>
</style>
