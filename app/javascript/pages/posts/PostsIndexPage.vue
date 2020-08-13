<template>
  <div>
    <div v-for="p in posts" :key="p.id">
      <p>
        <router-link :to="{ name: 'PostsShowPage', params: { id: p.id } }">{{ p.id }}</router-link>
      </p>
      <p>{{ p.id }}</p>
      <p>{{ p.title }}</p>
      <p>{{ p.body }}</p>
      <p>{{ p.post_image }}</p>
      <!-- <p>{{ p.category_ids }}</p> -->
      <like-button :post-id="p.id"></like-button>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import LikeButton from "../../components/Like/LikeButton.vue";

export default {
  components: { LikeButton },
  data() {
    return {
      posts: [],
    };
  },
  created() {
    axios
      .get("/api/v1/posts.json")
      .then((response) => (this.posts = response.data));
  },
};
</script>

<style scoped>
</style>
