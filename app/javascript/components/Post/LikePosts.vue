<template>
  <div>
    <v-row justify="center" class="mx-auto">
      <router-view @update-posts="$emit('update-posts')"></router-view>
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
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  components: { PostsIndexImage },
  data() {
    return {
      likePosts: [],
      likePostsNumber: 0,
      infiniteId: +new Date(),
    };
  },
  computed: {
    watchId() {
      return this.$route.params.id;
    },
  },
  watch: { watchId: "updatePosts" },
  methods: {
    updatePosts() {
      this.likePosts = [];
      this.likePostsNumber = 0;
      this.infiniteId += 1;
    },
    infiniteUserLikes($state) {
      if (this.likePostsNumber > -1) {
        axios
          .get(
            `/api/v1/likes/${this.$route.params.id}/posts?data_id=${this.likePostsNumber}`
          )
          .then(({ data }) => {
            this.likePosts.push(...data);
            if (15 > data.length) {
              this.likePostsNumber = -1;
            } else {
              this.likePostsNumber += 15;
            }
            $state.loaded();
          });
      }
    },
  },
};
</script>
<style scoped>
</style>
