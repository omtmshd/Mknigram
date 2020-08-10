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
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data: function () {
    return {
      posts: [],
    };
  },
  mounted() {
    axios
      .get("/api/v1/posts.json")
      .then((response) => (this.posts = response.data));
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
