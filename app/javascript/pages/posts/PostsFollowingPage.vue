<template>
  <posts-index-show :posts-data="posts" @update-posts="updatePosts()"></posts-index-show>
</template>
<script>
import axios from "axios";

import PostsIndexShow from "../../components/Post/PostsIndexShow.vue";

export default {
  components: { PostsIndexShow },
  data() {
    return {
      posts: [],
    };
  },
  mounted() {
    this.updatePosts();
  },
  methods: {
    async setPosts() {
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
<style scoped>
</style>
