<template>
  <div>
    <router-view @update-posts="updatePosts"></router-view>
    <v-row justify="center">
      <v-col>
        <posts-index-image v-for="postFirst in postsFirst" :key="postFirst.id" :post="postFirst"></posts-index-image>
        <infinite-loading @infinite="infiniteUserPosts" :identifier="infiniteId" spinner="spiral">
          <div slot="spinner"></div>
          <div slot="no-more"></div>
          <div slot="no-results"></div>
        </infinite-loading>
      </v-col>
      <v-col>
        <posts-index-image v-for="postScond in postsScond" :key="postScond.id" :post="postScond"></posts-index-image>
      </v-col>
      <v-col>
        <posts-index-image v-for="postThird in postsThird" :key="postThird.id" :post="postThird"></posts-index-image>
      </v-col>
    </v-row>
  </div>
</template>
<script>
import axios from "axios";

import PostsIndexImage from "./PostsIndexImage.vue";

export default {
  components: { PostsIndexImage },
  data() {
    return {
      postsFirst: [],
      postsScond: [],
      postsThird: [],
      userPostsNumber: 0,
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
      this.postsFirst = [];
      this.postsScond = [];
      this.postsThird = [];
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
            if (15 > data.length) {
              this.userPostsNumber = -1;
            } else {
              this.userPostsNumber += 15;
            }
            for (let i = 0; i < data.length; i++) {
              switch ((i + 1) % 3) {
                case 1:
                  this.postsFirst.push(data[i]);
                  break;
                case 2:
                  this.postsScond.push(data[i]);
                  break;
                case 0:
                  this.postsThird.push(data[i]);
                  break;
              }
            }
            $state.loaded();
          });
      }
    },
  },
};
</script>
<style scoped>
.col {
  padding: 0;
}
</style>
