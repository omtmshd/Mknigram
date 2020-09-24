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
import CategorySearchPage from "./posts/CategorySearchPage.vue";
import PostsLikesPage from "./posts/PostsLikesPage.vue";

import PostsModal from "../components/Post/PostsModal.vue";

import PostsNewPage from "./posts/PostsNewPage.vue";
import PostsEditPage from "./posts/PostsEditPage.vue";

import UsersIndexPage from "./users/UsersIndexPage.vue";
import UsersShowPage from "./users/UsersShowPage.vue";

import UserPosts from "../components/Post/UserPosts.vue";
import LikePosts from "../components/Post/LikePosts.vue";
import ListFolderIndex from "../components/List/ListFolderIndex.vue";

import ListForm from "../components/List/ListForm.vue";
import ListFolderNew from "../components/List/ListFolderNew.vue";

import LoginPage from "./login/LoginPage.vue";
import ListFolderNewVue from "../components/List/ListFolderNew.vue";

const router = new VueRouter({
  routes: [
    { path: "/posts/new", name: "PostsNewPage", component: PostsNewPage },
    {
      path: "/posts/:id(\\d+)/edit",
      name: "PostsEditPage",
      component: PostsEditPage,
    },
    {
      path: "/",
      component: PostsFollowingPage,
      children: [
        {
          path: ":post_id(\\d+)",
          component: PostsModal,
          children: [
            { path: "lists", component: ListForm },
            { path: "folders", component: ListFolderNew },
          ],
        },
      ],
    },
    {
      path: "/posts/likes",
      name: "PostsLikesPage",
      component: PostsLikesPage,
      children: [
        {
          path: ":post_id(\\d+)",
          component: PostsModal,
          children: [
            { path: "lists", component: ListForm },
            { path: "folders", component: ListFolderNew },
          ],
        },
      ],
    },
    {
      path: "/categories/:id(\\d+)/search",
      name: "CategorySearchPage",
      component: CategorySearchPage,
      children: [
        {
          path: ":post_id(\\d+)",
          component: PostsModal,
          children: [
            { path: "lists", component: ListForm },
            { path: "folders", component: ListFolderNew },
          ],
        },
      ],
    },
    {
      path: "/users/:id(\\d+)",
      component: UsersShowPage,
      children: [
        {
          path: "posts",
          component: UserPosts,
          name: "UserPostsPage",
          children: [
            {
              path: ":post_id(\\d+)",
              component: PostsModal,
              children: [
                { path: "lists", component: ListForm },
                { path: "folders", component: ListFolderNew },
              ],
            },
          ],
        },
        {
          path: "likes",
          component: LikePosts,
          name: "LikePostsPage",
          children: [
            {
              path: ":post_id(\\d+)",
              component: PostsModal,
              children: [
                { path: "lists", component: ListForm },
                { path: "folders", component: ListFolderNew },
              ],
            },
          ],
        },
        {
          path: "list_folders",
          component: ListFolderIndex,
          name: "ListFolderIndex",
        },
      ],
    },
    { path: "/users", name: "UsersIndexPage", component: UsersIndexPage },
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

