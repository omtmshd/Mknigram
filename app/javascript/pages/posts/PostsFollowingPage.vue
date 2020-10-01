<template>
  <div>
    <router-view></router-view>
    <v-card color="rgba(0,0,0,0)" flat class="mx-auto" :width="cardWidth">
      <v-row justify="center">
        <v-col>
          <posts-index-image v-for="postFirst in postsFirst" :key="postFirst.id" :post="postFirst"></posts-index-image>
          <infinite-loading @infinite="infiniteFirst" spinner="spiral">
            <div slot="spinner"></div>
            <div slot="no-more"></div>
            <div slot="no-results"></div>
          </infinite-loading>
        </v-col>
        <v-col>
          <posts-index-image v-for="postScond in postsScond" :key="postScond.id" :post="postScond"></posts-index-image>
          <infinite-loading @infinite="infiniteScond" spinner="spiral">
            <div slot="spinner"></div>
            <div slot="no-more"></div>
            <div slot="no-results"></div>
          </infinite-loading>
        </v-col>
        <v-col>
          <posts-index-image v-for="postThird in postsThird" :key="postThird.id" :post="postThird"></posts-index-image>
          <infinite-loading @infinite="infiniteThird" spinner="spiral">
            <div slot="spinner"></div>
            <div slot="no-more"></div>
            <div slot="no-results"></div>
          </infinite-loading>
        </v-col>
      </v-row>
    </v-card>
    <v-btn fixed dark fab bottom right color="#263238" @click="$vuetify.goTo(0)">
      <v-icon>mdi-chevron-double-up</v-icon>
    </v-btn>
  </div>
</template>
<script>
import axios from "axios";

import PostsIndexImage from "../../components/Post/PostsIndexImage.vue";

export default {
  components: { PostsIndexImage },
  data() {
    return {
      postsFirstNumber: 0,
      postsScondNumber: 5,
      postsThirdNumber: 10,
      postsFirst: [],
      postsScond: [],
      postsThird: [],
    };
  },
  methods: {
    updatePosts() {
      this.postsFirst = [];
      this.postsScond = [];
      this.postsThird = [];
      this.postsFirstNumber = 0;
      this.postsScondNumber = 5;
      this.postsThirdNumber = 10;
    },
    infiniteFirst($state) {
      axios
        .get(`/api/v1/posts?data_id=${this.postsFirstNumber}`)
        .then(({ data }) => {
          this.postsFirstNumber += 15;
          this.postsFirst.push(...data);
          if (5 > data.length) {
            $state.complete();
          } else {
            $state.loaded();
          }
        });
    },
    infiniteScond($state) {
      axios
        .get(`/api/v1/posts?data_id=${this.postsScondNumber}`)
        .then(({ data }) => {
          this.postsScondNumber += 15;
          this.postsScond.push(...data);
          if (5 > data.length) {
            $state.complete();
          } else {
            $state.loaded();
          }
        });
    },
    infiniteThird($state) {
      axios
        .get(`/api/v1/posts?data_id=${this.postsThirdNumber}`)
        .then(({ data }) => {
          this.postsThirdNumber += 15;
          this.postsThird.push(...data);
          if (5 > data.length) {
            $state.complete();
          } else {
            $state.loaded();
          }
        });
    },
  },
  computed: {
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "320";
        case "sm":
          return "950";
        default:
          return "1230";
      }
    },
  },
};
</script>
<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: 0.5s;
}
.col {
  padding: 0;
}
</style>
