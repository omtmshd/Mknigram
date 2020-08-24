<template>
  <posts-index :posts-data="posts"></posts-index>
</template>
<script>
import PostsIndex from "../../components/Post/PostsIndex.vue";
import axios from "axios";

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
  },
};
</script>

<style>
</style>
