<template>
  <div>
    <v-row justify="center" class="mx-auto">
      <div v-for="post in userPosts" :key="post.index">
        <v-img :srd="post.post_image.url" width="0" height="0"></v-img>
      </div>
      <posts-index-image
        v-for="userPost in userPosts"
        :key="userPost.index"
        :post="userPost"
        :current-user="currentUser"
        @update-posts="updatePosts"
      ></posts-index-image>
    </v-row>
    <infinite-loading @infinite="infiniteUserPosts" :identifier="infiniteId" spinner="spiral">
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
      userPosts: [],
      userPostsNumber: 0,
      infiniteId: +new Date(),
    };
  },
  watch: { $route: "updatePosts" },
  methods: {
    updatePosts() {
      this.userPosts = [];
      this.userPostsNumber = 0;
      this.infiniteId += 1;
    },
    infiniteUserPosts($state) {
      if (this.userPostsNumber > -1) {
        axios
          .get(
            `/api/v1/users/${this.$route.params.id}/posts?data_id=${this.userPostsNumber}`
          )
          .then(({ data }) => {
            this.userPosts.push(...data);
            if (15 > data.length) {
              this.userPostsNumber = -1;
            } else {
              this.userPostsNumber += 15;
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
