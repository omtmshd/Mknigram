<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import PostsIndex from "./PostsIndex.vue";
import PostShow from "./PostShow.vue";
import PostNew from "./PostNew.vue";
import PostEdit from "./PostEdit.vue";

const router = new VueRouter({
  routes: [
    { path: "/", component: PostsIndex },
    { path: "/posts/:id(\\d+)", name: "PostShow", component: PostShow },
    { path: "/posts/new", name: "PostNew", component: PostNew },
    { path: "/posts/:id(\\d+)/edit", name: "PostEdit", component: PostEdit },
  ],
});

Vue.use(VueRouter);

export default {
  router,
};
</script>

<style scoped>
</style>
