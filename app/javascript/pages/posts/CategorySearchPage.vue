<template>
  <div>
    <router-view @update-posts="$emit('update-posts')"></router-view>
    <div :width="cardWidth" v-if="dsplayPc">
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
          <v-card
            max-height="100vh"
            class="overflow-y-auto"
            color="rgba(0,0,0,0)"
            flat
            :width="cardWidth"
          >
            <v-row justify="start">
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
      <v-card color="rgba(0,0,0,0)" flat class="mx-auto" :width="cardWidth">
        <v-container>
          <v-card width="330" color="rgba(0,0,0,0)" class="mx-auto">
            <category-bar></category-bar>
          </v-card>
        </v-container>

        <div>
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
          <infinite-loading @infinite="infiniteHandler" :identifier="infiniteId" spinner="spiral">
            <div slot="spinner"></div>
            <div slot="no-more"></div>
            <div slot="no-results"></div>
          </infinite-loading>
        </div>
      </v-card>
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
      postsFirst: [],
      postsScond: [],
      postsThird: [],
      postsNumber: 0,
      infiniteId: 0,
    };
  },
  watch: { watchId: "updatePosts" },
  mounted() {
    this.updatePosts();
  },
  methods: {
    updatePosts() {
      this.postsFirst = [];
      this.postsScond = [];
      this.postsThird = [];
      this.postsNumber = 0;
      this.infiniteId++;
    },
    infiniteHandler($state) {
      if (Number(this.$route.params.id) === 0) {
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
      } else {
        if (this.postsNumber > -1) {
          axios
            .get(
              `/api/v1/categories/${this.$route.params.id}/search?data_id=${this.postsNumber}`
            )
            .then(({ data }) => {
              if (15 > data.length) {
                this.postsNumber = -1;
              } else {
                this.postsNumber += 15;
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
      }
    },
  },
  computed: {
    watchId() {
      return this.$route.params.id;
    },
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
    categoryWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "150";
        case "sm":
          return "250";
        default:
          return "250";
      }
    },
    dsplayPc() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return false;
        case "sm":
          return false;
        default:
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
