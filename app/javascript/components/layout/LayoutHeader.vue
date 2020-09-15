<template>
  <header id="header">
    <v-app-bar app color="white">
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-icon color="#FBC02D">mdi-fruit-watermelon</v-icon>
      <v-toolbar-title>Mknigram</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-menu bottom left v-if="currentUser !== null">
        <template v-slot:activator="{ on, attrs }">
          <v-btn icon v-bind="attrs" v-on="on">
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>

        <v-card>
          <v-container>
            <v-list>
              <v-list-item two-line @click="usersShow">
                <v-list-item-avatar size="30">
                  <v-img
                    v-if="currentUser.profile_image.url !== null"
                    :src="currentUser.profile_image.url"
                  ></v-img>
                  <v-icon v-else size="30" color="#90A4AE" dark>mdi-account-circle</v-icon>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title>{{ currentUser.name }}</v-list-item-title>
                  <v-list-item-subtitle>Logged In</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list>

            <v-divider></v-divider>

            <v-list>
              <v-list-item @click="usersIndex">
                <v-list-item-action>
                  <v-icon>mdi-account-group</v-icon>
                </v-list-item-action>
                <v-list-item-title>ユーザー一覧</v-list-item-title>
              </v-list-item>

              <v-list-item @click.stop="showModal = true">
                <v-list-item-action>
                  <v-icon>mdi-logout-variant</v-icon>
                </v-list-item-action>
                <v-list-item-title>ログアウト</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-container>
        </v-card>
      </v-menu>
      <v-btn v-else text @click="logIn">ログイン</v-btn>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" temporary app>
      <v-list nav>
        <v-list-item v-if="currentUser !== null" link @click="postsNew">
          <v-list-item-action>
            <v-icon>mdi-folder-edit</v-icon>
          </v-list-item-action>
          <v-list-item-title>レシピを書く</v-list-item-title>
        </v-list-item>

        <v-list-item link @click="postsIndex">
          <v-list-item-action>
            <v-icon>mdi-egg-easter</v-icon>
          </v-list-item-action>
          <v-list-item-title>最近のレシピ</v-list-item-title>
        </v-list-item>

        <v-list-item link @click="likesPosts">
          <v-list-item-action>
            <v-icon>mdi-crown-outline</v-icon>
          </v-list-item-action>
          <v-list-item-title>人気のレシピ</v-list-item-title>
        </v-list-item>

        <v-divider></v-divider>

        <v-list-item link @click="searchPosts(0)">
          <v-list-item-title>カテゴリーから探す</v-list-item-title>
          <v-list-item-action>
            <v-icon>mdi-chevron-triple-right</v-icon>
          </v-list-item-action>
        </v-list-item>
        <v-list dense nav>
          <v-list-item v-for="c in categories" :key="c.id" link @click="searchPosts(c.id)">
            <v-list-item-title>
              {{ c.name }}
              <span class="text--secondary">({{c.posts_count}}品)</span>
            </v-list-item-title>
            <v-list-item-action>
              <v-icon>mdi-chevron-right</v-icon>
            </v-list-item-action>
          </v-list-item>
        </v-list>
      </v-list>
    </v-navigation-drawer>
    <user-logout-modal v-if="showModal" @cancel="showModal = false" @ok="logOut">
      <div slot="body">本当にログアウトしますか？</div>
    </user-logout-modal>
  </header>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";
import UserLogoutModal from "../User/UserLogoutModal.vue";

export default {
  mixins: [currentUser],
  components: { UserLogoutModal },
  data() {
    return {
      drawer: false,
      showModal: false,
      categories: [],
    };
  },
  mounted() {
    this.getCategories();
  },
  methods: {
    postsNew() {
      if (this.$route.name !== "PostsNewPage") {
        this.$router.push({
          name: "PostsNewPage",
        });
      } else {
        this.drawer = false;
      }
    },
    postsIndex() {
      if (this.$route.path !== "/") {
        this.$router.push({ path: "/" });
      } else {
        this.drawer = false;
      }
    },
    likesPosts() {
      if (this.$route.name !== "PostsLikesPage") {
        this.$router.push({
          name: "PostsLikesPage",
        });
      } else {
        this.drawer = false;
      }
    },

    usersIndex() {
      if (this.$route.name !== "UsersIndexPage") {
        this.$router.push({
          name: "UsersIndexPage",
        });
      } else {
        this.drawer = false;
      }
    },
    usersShow() {
      if (this.$route.path !== `/users/${this.currentUser.id}/`) {
        this.$router.push({
          name: "UserPostsPage",
          params: { id: this.currentUser.id },
        });
      } else {
        this.drawer = false;
      }
    },
    getCategories() {
      axios.get("/api/v1/categories/parents").then(({ data }) => {
        this.categories = data;
      });
    },
    searchPosts(i) {
      if (this.$route.path !== `/posts/${i}/categories`) {
        this.$router.push(`/posts/${i}/categories`);
      }
    },
    async logOut() {
      await axios
        .delete("/api/v1/auth/sign_out", {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then(
          (response) => {
            // レスポンスで返ってきた、認証に必要な情報をlocalStorageに保存
            localStorage.setItem(
              "access-token",
              response.headers["access-token"]
            );
            localStorage.setItem("expiry", response.headers.expiry);
            localStorage.setItem("client", response.headers.client);
            localStorage.setItem("uid", response.headers.uid);
            localStorage.setItem("token-type", response.headers["token-type"]);
            return response;
          },
          (error) => {
            return error;
          }
        );
      this.showModal = false;
      this.$router.push({ name: "LoginPage" });
    },
    logIn() {
      if (this.$route.name !== "LoginPage") {
        this.$router.push({ name: "LoginPage" });
      } else {
        this.drawer = false;
      }
    },
  },
};
</script>
<style>
</style>
