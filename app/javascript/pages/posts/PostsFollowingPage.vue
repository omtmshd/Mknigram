<template>
  <div>
    <div v-for="post in postsData" :key="post.index">
      <v-img :srd="post.post_image.url" width="0" height="0"></v-img>
    </div>

    <post-show
      v-for="post in postsData"
      :key="post.index"
      :post="post"
      :current-user="currentUser"
      :card-color="cardColor"
      @update-posts="updatePosts()"
    ></post-show>
    <infinite-loading @infinite="infiniteHandler" spinner="spiral">
      <div slot="spinner"></div>
      <div slot="no-more"></div>
      <div slot="no-results"></div>
    </infinite-loading>
    <v-btn fixed dark fab bottom right color="#263238" @click="$vuetify.goTo(0)">
      <v-icon>mdi-chevron-double-up</v-icon>
    </v-btn>
  </div>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";

import PostShow from "../../components/Post/PostShow.vue";

export default {
  mixins: [currentUser],
  components: { PostShow },
  data() {
    return {
      postsData: [],
      postsNumber: 0,
      cardColor: "rgba(255,255,255,0.85)",
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
.fade-enter-active,
.fade-leave-active {
  transition: 0.5s;
}
</style>
