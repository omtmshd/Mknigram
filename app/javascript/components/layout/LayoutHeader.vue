<template>
  <header id="header">
    <v-app-bar app color="white">
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-icon color="#FBC02D">mdi-pumpkin</v-icon>
      <v-toolbar-title class="font-weight-black">VeGGram</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-menu bottom left v-if="currentUser.id > 0">
        <template v-slot:activator="{ on, attrs }">
          <v-btn icon v-bind="attrs" v-on="on">
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>

        <v-card>
          <v-container>
            <v-list>
              <v-list-item @click="usersShow">
                <v-avatar size="60" class="mx-auto">
                  <v-img
                    v-if="currentUser.profile_image.url !== null"
                    :src="currentUser.profile_image.url"
                  ></v-img>
                  <v-icon v-else size="60" color="#90A4AE" dark>mdi-account-circle</v-icon>
                </v-avatar>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title class="text-center">{{ currentUser.name }}</v-list-item-title>
                  <v-list-item-subtitle class="text-center">{{ currentUser.email }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list>

            <v-divider></v-divider>

            <v-list>
              <v-list-item @click="usersIndex">
                <v-list-item-content class="text-subtitle-2">ユーザー一覧</v-list-item-content>
              </v-list-item>

              <v-list-item @click.stop="showModal = true">
                <v-list-item-content class="text-subtitle-2">ログアウト</v-list-item-content>
                <v-list-item-action>
                  <v-icon>mdi-transfer-right</v-icon>
                </v-list-item-action>
              </v-list-item>
            </v-list>
          </v-container>
        </v-card>
      </v-menu>
      <v-btn v-else text @click="logIn">ログイン</v-btn>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" temporary app>
      <v-list nav>
        <v-list-item link @click="postsNew">
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

        <v-list-item link @click="categorySearch(0)">
          <v-list-item-title>カテゴリーから探す</v-list-item-title>
          <v-list-item-action>
            <v-icon>mdi-chevron-triple-right</v-icon>
          </v-list-item-action>
        </v-list-item>
        <v-list dense nav>
          <v-list-item v-for="c in categories" :key="c.id" link @click="categorySearch(c.id)">
            <v-list-item-title>
              {{ c.name }}
              <span class="text--secondary">({{c.posts_count}}品)</span>
            </v-list-item-title>
            <v-list-item-action>
              <v-icon>mdi-chevron-right</v-icon>
            </v-list-item-action>
          </v-list-item>
        </v-list>

        <template v-if="currentUser.id > 0">
          <v-divider></v-divider>

          <v-list-item link @click="listsIndexPage">
            <v-list-item-action>
              <v-icon>mdi-playlist-play</v-icon>
            </v-list-item-action>
            <v-list-itme-title>マイリスト</v-list-itme-title>
          </v-list-item>
          <v-list dense nav>
            <v-list-item
              v-for="list_folder in list_folders"
              :key="list_folder.id"
              @click="listsShowPage(list_folder.id)"
            >
              <v-list-item-action>
                <v-icon>mdi-minus</v-icon>
              </v-list-item-action>
              <v-list-item-title>{{ list_folder.name }}</v-list-item-title>
            </v-list-item>
          </v-list>
        </template>
      </v-list>
    </v-navigation-drawer>

    <user-logout-modal v-if="showModal" @cancel="showModal = false" @ok="logOut">
      <div slot="body">本当にログアウトしますか？</div>
    </user-logout-modal>

    <v-snackbar
      v-model="snackbar"
      top
      right
      light
      transition="scroll-x-reverse-transition"
      :timeout="2000"
    >
      ログインしてくだい
      <template v-slot:action="{ attrs }">
        <v-btn color="#37474F" text v-bind="attrs" @click="snackbar = false">閉じる</v-btn>
      </template>
    </v-snackbar>
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
      snackbar: false,
      list_folders: [],
    };
  },
  mounted() {
    this.getCategories();
    this.setListFolders();
  },
  watch: { currentUser: "setListFolders" },
  methods: {
    postsNew() {
      if (this.currentUser.id > 0) {
        if (this.$route.name !== "PostsNewPage") {
          this.$router.push({
            name: "PostsNewPage",
          });
        } else {
          this.drawer = false;
        }
      } else {
        this.snackbar = true;
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
      if (this.$route.path !== `/users/${this.currentUser.id}/posts`) {
        this.$router.push(`/users/${this.currentUser.id}/posts`);
      } else {
        this.drawer = false;
      }
    },
    getCategories() {
      axios.get("/api/v1/categories/parents").then(({ data }) => {
        this.categories = data;
      });
    },
    categorySearch(i) {
      if (this.$route.path !== `/categories/${i}/search`) {
        this.$router.push(`/categories/${i}/search`);
      } else {
        this.drawer = false;
      }
    },
    setListFolders() {
      if (this.currentUser.id > 0) {
        axios
          .get(`/api/v1/users/${this.currentUser.id}/list_folders`)
          .then(({ data }) => {
            this.list_folders = data;
          });
      }
    },
    listsIndexPage() {
      if (this.$route.path !== `/users/${this.currentUser.id}/list_folders`) {
        this.$router.push(`/users/${this.currentUser.id}/list_folders`);
      } else {
        this.drawer = false;
      }
    },
    listsShowPage(i) {
      if (this.$route.path !== `/list_folders/${i}/posts`) {
        this.$router.push(`/list_folders/${i}/posts`);
      } else {
        this.drawer = false;
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
.v-navigation-drawer--temporary {
  z-index: 300;
}
</style>
