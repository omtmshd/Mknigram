<template>
  <posts-index :posts-data="posts" @update-posts="updatePosts()"></posts-index>
</template>
<script>
import PostsIndex from "../../components/Post/PostsIndex.vue";
import axios from "axios";
import { csrfToken } from "rails-ujs";
axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

export default {
  components: { PostsIndex },
  data() {
    return {
      posts: [],
    };
  },
  created() {
    this.setPosts().then((result) => {
      this.posts = result;
    });
  },
  methods: {
    setPosts: async function () {
      const res = await axios.get("/api/v1/posts.json");
      return res.data;
    },
    updatePosts() {
      this.setPosts().then((result) => {
        this.posts = result;
      });
    },
  },
};
</script>

<style>
</style>
