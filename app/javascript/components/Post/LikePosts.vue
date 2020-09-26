<template>
  <div>
    <router-view @update-posts="$emit('update-posts')"></router-view>
    <v-row justify="center">
      <v-col>
        <posts-index-image
          v-for="postFirst in postsFirst"
          :key="postFirst.id"
          :post="postFirst"
          :current-user="currentUser"
          @update-posts="updatePosts"
        ></posts-index-image>
      </v-col>
      <v-col>
        <posts-index-image
          v-for="postScond in postsScond"
          :key="postScond.id"
          :post="postScond"
          :current-user="currentUser"
          @update-posts="updatePosts"
        ></posts-index-image>
      </v-col>
      <v-col>
        <posts-index-image
          v-for="postThird in postsThird"
          :key="postThird.id"
          :post="postThird"
          :current-user="currentUser"
          @update-posts="updatePosts"
        ></posts-index-image>
      </v-col>
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
      postsFirst: [],
      postsScond: [],
      postsThird: [],
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
      this.postsFirst = [];
      this.postsScond = [];
      this.postsThird = [];
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
            if (15 > data.length) {
              this.likePostsNumber = -1;
            } else {
              this.likePostsNumber += 15;
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
