<template>
  <div>
    <posts-index-show
      v-for="post in postsData"
      :key="post.index"
      :post="post"
      :current-user="currentUser"
      @update-posts="updatePosts()"
    ></posts-index-show>
    <infinite-loading @infinite="infiniteHandler" spinner="spiral">
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
    };
  },
  methods: {
    updatePosts() {
      this.postsData = [];
      this.postsNumber = 0;
      this.infiniteHandler();
    },
    infiniteHandler($state) {
      axios
        .get(`/api/v1/posts?data_id=${this.postsNumber}`)
        .then(({ data }) => {
          this.postsNumber += 10;
          this.postsData.push(...data);
          if (10 > data.length) {
            $state.complete();
          } else {
            $state.loaded();
          }
        });
    },
  },
};
</script>
<style scoped>
</style>
