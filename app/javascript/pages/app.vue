<template>
  <v-app id="appfull">
    <layout-header></layout-header>

    <v-container fill-height fluid id="display">
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
import UserPosts from "../components/Post/UserPosts.vue";
import LikePosts from "../components/Post/LikePosts.vue";

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
      component: UsersShowPage,
      children: [
        { path: "", component: UserPosts, name: "UserPostsPage" },
        { path: "like", component: LikePosts, name: "LikePostsPage" },
      ],
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
#appfull {
  width: 100%;
}
#display {
  margin: 0;
  padding: 0;
  background-image: url("../../assets/images/back_img_2.jpg");
  background-size: cover;
  background-position: bottom;
  background-repeat: no-repeat;
  background-attachment: fixed;
  z-index: 0;
  overflow: hidden;
}
</style>

