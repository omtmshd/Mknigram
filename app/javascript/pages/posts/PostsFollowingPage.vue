<template>
  <div>
    <router-view></router-view>
    <v-card color="rgba(0,0,0,0)" flat class="mx-auto" :width="cardWidth">
      <v-row justify="center">
        <v-col>
          <posts-index-image v-for="postFirst in postsFirst" :key="postFirst.id" :post="postFirst"></posts-index-image>
          <infinite-loading @infinite="infiniteHandler" spinner="spiral">
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
      postsNumber: 0,
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
      this.postsNumber = 0;
    },
    infiniteHandler($state) {
      axios
        .get(`/api/v1/posts?data_id=${this.postsNumber}`)
        .then(({ data }) => {
          this.postsNumber += 15;
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
          if (15 > data.length) {
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
