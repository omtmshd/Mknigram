<template>
  <div>
    <posts-index-show
      v-for="post in postsData"
      :key="post.index"
      :post="post"
      :current-user="currentUser"
      @update-posts="updatePosts()"
    ></posts-index-show>
    <infinite-loading @infinite="infiniteHandler" :identifier="infiniteId" spinner="spiral">
      <div slot="spinner"></div>
      <div slot="no-more"></div>
      <div slot="no-results"></div>
    </infinite-loading>
  </div>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";

import PostsIndexShow from "../../components/Post/PostsIndexShow.vue";

export default {
  mixins: [currentUser],
  components: { PostsIndexShow },
  data() {
    return {
      postsData: [],
      postsNumber: 0,
      infiniteId: 0,
    };
  },
  watch: { $route: "updatePosts" },
  methods: {
    updatePosts() {
      this.postsData = [];
      this.postsNumber = 0;
      this.infiniteId++;
    },
    infiniteHandler($state) {
      if (this.postsNumber > -1) {
        axios
          .get(
            `/api/v1/posts/${this.$route.params.id}/categories?data_id=${this.postsNumber}`
          )
          .then(({ data }) => {
            this.postsData.push(...data);
            if (5 > data.length) {
              this.postsNumber = -1;
              $state.loaded();
            } else {
              this.postsNumber += 5;
              $state.loaded();
            }
          });
      }
    },
  },
};
</script>
<style scoped>
</style>
