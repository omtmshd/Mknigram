<template>
  <div>
    <v-row justify="center" class="mx-auto">
      <div v-for="post in likePosts" :key="post.index">
        <v-img :srd="post.post_image.url" width="0" hight="0"></v-img>
      </div>
      <posts-index-image
        v-for="likePost in likePosts"
        :key="likePost.index"
        :post="likePost"
        :current-user="currentUser"
        @update-posts="updatePosts"
      ></posts-index-image>
    </v-row>
    <infinite-loading @infinite="infiniteUserLikes" :identifier="infiniteId" spinner="spiral">
      <div slot="spinner"></div>
      <div slot="no-more"></div>
      <div slot="no-results"></div>
    </infinite-loading>
  </div>
</template>
<script>
import axios from "axios";

import PostsIndexImage from "./PostsIndexImage.vue";

export default {
  components: { PostsIndexImage },
  props: {
    currentUser: {},
  },
  data() {
    return {
      likePosts: [],
      likePostsNumber: 0,
      infiniteId: +new Date(),
    };
  },
  watch: { $route: "updatePosts" },
  methods: {
    updatePosts() {
      this.likePosts = [];
      this.likePostsNumber = 0;
      this.infiniteId += 1;
    },
    infiniteUserLikes($state) {
      axios
        .get(
          `/api/v1/likes/${this.$route.params.id}/posts?data_id=${this.likePostsNumber}`
        )
        .then(({ data }) => {
          if (9 > data.length) {
            this.likePosts.push(...data);
            $state.complete();
          } else {
            this.likePostsNumber += 9;
            this.likePosts.push(...data);
            $state.loaded();
          }
        });
    },
  },
};
</script>
<style scoped>
</style>
