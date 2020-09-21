<template>
  <div>
    <div :width="cardWidth" v-if="dsplayPc">
      <div v-for="post in postsData" :key="post.index">
        <v-img :srd="post.post_image.url" width="0" height="0"></v-img>
      </div>
      <v-row justify="center">
        <v-col cols="3">
          <v-card
            max-height="800"
            :width="categoryWidth"
            color="rgba(0,0,0,0)"
            flat
            class="mr-0 ml-auto"
          >
            <category-bar></category-bar>
          </v-card>
        </v-col>
        <v-col cols="9">
          <v-card max-height="100vh" class="overflow-y-auto" color="rgba(0,0,0,0)" flat>
            <v-row justify="start" class="ml-3 mr-auto">
              <posts-index-image
                v-for="post in postsData"
                :key="post.index"
                :post="post"
                :current-user="currentUser"
                @update-posts="updatePosts"
              ></posts-index-image>
            </v-row>
            <infinite-loading @infinite="infiniteHandler" :identifier="infiniteId" spinner="spiral">
              <div slot="spinner"></div>
              <div slot="no-more"></div>
              <div slot="no-results"></div>
            </infinite-loading>
          </v-card>
        </v-col>
      </v-row>
    </div>
    <div v-else>
      <v-container>
        <v-row justify="center">
          <v-card width="330" color="rgba(0,0,0,0)">
            <category-bar></category-bar>
          </v-card>
        </v-row>

        <div>
          <div v-for="post in postsData" :key="post.index">
            <v-img :srd="post.post_image.url" width="0" height="0"></v-img>
          </div>
          <v-row justify="center" class="mx-auto">
            <posts-index-image
              v-for="post in postsData"
              :key="post.index"
              :post="post"
              :current-user="currentUser"
              @update-posts="updatePosts"
            ></posts-index-image>
          </v-row>
          <infinite-loading @infinite="infiniteHandler" :identifier="infiniteId" spinner="spiral">
            <div slot="spinner"></div>
            <div slot="no-more"></div>
            <div slot="no-results"></div>
          </infinite-loading>
        </div>
      </v-container>
    </div>
  </div>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";

import PostsIndexImage from "../../components/Post/PostsIndexImage.vue";
import CategoryBar from "../../components/Category/CategoryBar.vue";

export default {
  mixins: [currentUser],
  components: { PostsIndexImage, CategoryBar },
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
      if (Number(this.$route.params.id) === 0) {
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
      } else {
        if (this.postsNumber > -1) {
          axios
            .get(
              `/api/v1/categories/${this.$route.params.id}/search?data_id=${this.postsNumber}`
            )
            .then(({ data }) => {
              this.postsData.push(...data);
              if (10 > data.length) {
                this.postsNumber = -1;
                $state.loaded();
              } else {
                this.postsNumber += 10;
                $state.loaded();
              }
            });
        }
      }
    },
  },
  computed: {
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "100%";
        case "sm":
          return "100%";
        case "md":
          return "1200";
        case "lg":
          return "1200";
        case "xl":
          return "1200";
      }
    },
    categoryWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "150";
        case "sm":
          return "180";
        case "md":
          return "250";
        case "lg":
          return "250";
        case "xl":
          return "250";
      }
    },
    dsplayPc() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return false;
        case "sm":
          return true;
        case "md":
          return true;
        case "lg":
          return true;
        case "xl":
          return true;
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
