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
            <div v-if="categoryIndex">
              <v-list>
                <v-list-item link v-if="category.parent" @click="searchPosts(category.parent.id)">
                  <v-list-item-action>
                    <v-icon color="#FBC02D">mdi-chevron-left</v-icon>
                  </v-list-item-action>
                  <v-list-item-title>
                    {{category.parent.name}}
                    <span
                      class="text--disabled"
                    >({{category.parent.posts_count}}品)</span>
                  </v-list-item-title>
                </v-list-item>
                <v-list-item link v-else @click="searchPosts(0)">
                  <v-list-item-action>
                    <v-icon color="#FBC02D">mdi-chevron-left</v-icon>
                  </v-list-item-action>
                  <v-list-item-title>カテゴリー一覧</v-list-item-title>
                </v-list-item>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title class="title">
                      {{category.name}}
                      <span class="text--disabled">({{category.posts_count}}品)</span>
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </div>
            <div v-else>
              <v-list>
                <v-list-item>
                  <v-list-item-action>
                    <v-icon color="#FBC02D">mdi-chevron-triple-down</v-icon>
                  </v-list-item-action>
                  <v-list-item-title>カテゴリーを選択</v-list-item-title>
                </v-list-item>
              </v-list>
            </div>
            <v-divider></v-divider>
            <v-list dense nav>
              <v-list-item
                v-for="sibling in category.siblings"
                :key="sibling.id"
                link
                @click="searchPosts(sibling.id)"
              >
                <v-list-item-title>
                  {{ sibling.name }}
                  <span class="text--secondary">({{sibling.posts_count}}品)</span>
                </v-list-item-title>
                <v-list-item-action>
                  <v-icon>mdi-chevron-right</v-icon>
                </v-list-item-action>
              </v-list-item>
            </v-list>

            <v-list dense nav>
              <v-list-item
                v-for="child in category.children"
                :key="child.id"
                link
                @click="searchPosts(child.id)"
              >
                <v-list-item-title>
                  {{ child.name }}
                  <span class="text--secondary">({{child.posts_count}}品)</span>
                </v-list-item-title>
                <v-list-item-action>
                  <v-icon>mdi-chevron-right</v-icon>
                </v-list-item-action>
              </v-list-item>
            </v-list>
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
            <div v-if="categoryIndex">
              <v-list>
                <v-list-item link v-if="category.parent" @click="searchPosts(category.parent.id)">
                  <v-list-item-action>
                    <v-icon color="#FBC02D">mdi-chevron-left</v-icon>
                  </v-list-item-action>
                  <v-list-item-title>
                    {{category.parent.name}}
                    <span
                      class="text--disabled"
                    >({{category.parent.posts_count}}品)</span>
                  </v-list-item-title>
                </v-list-item>
                <v-list-item link v-else @click="searchPosts(0)">
                  <v-list-item-action>
                    <v-icon color="#FBC02D">mdi-chevron-left</v-icon>
                  </v-list-item-action>
                  <v-list-item-title>カテゴリー一覧</v-list-item-title>
                </v-list-item>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title class="title">
                      {{category.name}}
                      <span class="text--disabled">({{category.posts_count}}品)</span>
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </div>
            <div v-else>
              <v-list>
                <v-list-item>
                  <v-list-item-action>
                    <v-icon color="#FBC02D">mdi-chevron-triple-down</v-icon>
                  </v-list-item-action>
                  <v-list-item-title>カテゴリーを選択</v-list-item-title>
                </v-list-item>
              </v-list>
            </div>
            <v-divider></v-divider>
            <v-list dense nav>
              <v-list-item
                v-for="sibling in category.siblings"
                :key="sibling.id"
                link
                @click="searchPosts(sibling.id)"
              >
                <v-list-item-title>
                  {{ sibling.name }}
                  <span class="text--secondary">({{sibling.posts_count}}品)</span>
                </v-list-item-title>
                <v-list-item-action>
                  <v-icon>mdi-chevron-right</v-icon>
                </v-list-item-action>
              </v-list-item>
            </v-list>

            <v-list dense nav>
              <v-list-item
                v-for="child in category.children"
                :key="child.id"
                link
                @click="searchPosts(child.id)"
              >
                <v-list-item-title>
                  {{ child.name }}
                  <span class="text--secondary">({{child.posts_count}}品)</span>
                </v-list-item-title>
                <v-list-item-action>
                  <v-icon>mdi-chevron-right</v-icon>
                </v-list-item-action>
              </v-list-item>
            </v-list>
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

export default {
  mixins: [currentUser],
  components: { PostsIndexImage },
  data() {
    return {
      postsData: [],
      postsNumber: 0,
      infiniteId: 0,
      categoryIndex: true,
      category: {
        id: "",
        name: "",
        children: [],
        siblings: [],
        parent: {},
      },
    };
  },
  mounted() {
    this.setCategories();
  },
  watch: { $route: "updatePosts" },
  methods: {
    setCategories() {
      if (Number(this.$route.params.id) === 0) {
        axios.get("/api/v1/categories/parents").then(({ data }) => {
          this.category.children = data;
          this.categoryIndex = false;
        });
      } else {
        axios
          .get(`/api/v1/categories/${this.$route.params.id}/children`)
          .then(({ data }) => {
            this.category = data;
            this.categoryIndex = true;
          });
      }
    },
    searchPosts(i) {
      if (this.$route.path !== `/posts/${i}/categories`) {
        this.$router.push(`/posts/${i}/categories`);
      }
    },
    updatePosts() {
      this.postsData = [];
      this.postsNumber = 0;
      this.infiniteId++;
      this.category = {};
      this.setCategories();
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
              `/api/v1/posts/${this.$route.params.id}/categories?data_id=${this.postsNumber}`
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
