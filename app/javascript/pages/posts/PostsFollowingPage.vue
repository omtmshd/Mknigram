<template>
  <div>
    <router-view @update-posts="$emit('update-posts')"></router-view>
    <v-card color="rgba(0,0,0,0)" flat class="mx-auto" max-width="1200">
      <v-row justify="center" class="mx-auto">
        <posts-index-image
          v-for="post in postsData"
          :key="post.index"
          :post="post"
          :current-user="currentUser"
          @update-posts="updatePosts"
        ></posts-index-image>
      </v-row>
      <infinite-loading @infinite="infiniteHandler" spinner="spiral">
        <div slot="spinner"></div>
        <div slot="no-more"></div>
        <div slot="no-results"></div>
      </infinite-loading>
    </v-card>
    <v-btn fixed dark fab bottom right color="#263238" @click="$vuetify.goTo(0)">
      <v-icon>mdi-chevron-double-up</v-icon>
    </v-btn>
  </div>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";

import PostsIndexImage from "../../components/Post/PostsIndexImage.vue";

export default {
  mixins: [currentUser],
  components: { PostsIndexImage },
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
          this.postsNumber += 15;
          this.postsData.push(...data);
          if (15 > data.length) {
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
.fade-enter-active,
.fade-leave-active {
  transition: 0.5s;
}
</style>
