<template>
  <div>
    <v-row justify="center" class="mx-auto">
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

export default {
  components: { PostsIndexImage },
  props: {
    currentUser: {},
  },
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
      axios
        .get(
          `/api/v1/users/${this.$route.params.id}/posts?data_id=${this.userPostsNumber}`
        )
        .then(({ data }) => {
          if (9 > data.length) {
            this.userPosts.push(...data);
            $state.complete();
          } else {
            this.userPostsNumber += 9;
            this.userPosts.push(...data);
            $state.loaded();
          }
        });
    },
  },
};
</script>
<style scoped>
</style>
