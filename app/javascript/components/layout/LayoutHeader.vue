<template>
  <header>
    <v-app-bar app dark>
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>

      <v-toolbar-title>Mknigram</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-toolbar-title v-if="currentUser === null">ログインしてください</v-toolbar-title>

      <v-btn icon @click="postsNew()">
        <v-icon>mdi-tooltip-edit-outline</v-icon>
      </v-btn>

      <v-menu bottom left>
        <template v-slot:activator="{ on, attrs }">
          <v-btn dark icon v-bind="attrs" v-on="on">
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>
        <v-card>
          <template v-if="currentUser !== null">
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
              <v-list-item @click="usersEdit">
                <v-list-item-action>
                  <v-icon>mdi-account-edit</v-icon>
                </v-list-item-action>
                <v-list-item-title>マイページ編集</v-list-item-title>
              </v-list-item>

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
          </template>
          <template v-else>
            <v-list-item link @click="logIn">
              <v-list-item-title>ログイン</v-list-item-title>
            </v-list-item>
            <v-list-item link @click="signIn">
              <v-list-item-title>新規登録</v-list-item-title>
            </v-list-item>
          </template>
        </v-card>
      </v-menu>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" temporary app>
      <v-list nav>
        <template v-if="currentUser !== null">
          <v-list-item link @click="postsIndex">
            <v-list-item-action>
              <v-icon>mdi-home</v-icon>
            </v-list-item-action>
            <v-list-item-title>Home</v-list-item-title>
          </v-list-item>

          <v-list-item link @click="postsNew">
            <v-list-item-action>
              <v-icon>mdi-tooltip-edit-outline</v-icon>
            </v-list-item-action>
            <v-list-item-title>レシピを書く</v-list-item-title>
          </v-list-item>

          <v-divider></v-divider>
        </template>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title>カテゴリーから探す</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-treeview
          dense
          color="warning"
          activatable
          :items="categories"
          :load-children="searchPosts"
          :active.sync="active"
          :open.sync="open"
          expand-icon="mdi-chevron-down"
          open-on-click
          transition
        ></v-treeview>
      </v-list>
    </v-navigation-drawer>
    <user-logout-modal
      v-if="showModal"
      @cancel="showModal = false"
      @ok="logOut; showModal = false;"
    >
      <div slot="body">本当にログアウトしますか？</div>
    </user-logout-modal>
  </header>
</template>
<script>
import axios from "axios";

import AssetsImage from "../../../assets/images/background_img.jpg";
import { currentUser } from "../../packs/mixins/currentUser";
import UserLogoutModal from "../User/UserLogoutModal.vue";

export default {
  mixins: [currentUser],
  components: { UserLogoutModal },
  data() {
    return {
      assetsImage: AssetsImage,
      drawer: false,
      showModal: false,
      categories: [],
      active: [],
      open: [],
    };
  },
  mounted() {
    this.getCategories();
  },
  watch: { $route: "resetCategories" },
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
    usersEdit() {
      if (this.$route.name !== "UsersEditPage") {
        this.$router.push({
          name: "UsersEditPage",
          params: { id: this.currentUser.id },
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
      if (this.$route.path !== `/users/${this.currentUser.id}`) {
        this.$router.push({
          name: "UsersShowPage",
          params: { id: this.currentUser.id },
        });
      } else {
        this.drawer = false;
      }
    },
    getCategories() {
      axios.get("/api/v1/categories").then(({ data }) => {
        this.categories = data;
      });
    },
    resetCategories() {
      this.active = [];
      this.open = [];
    },
    searchPosts(item) {
      if (this.$route.path !== `/posts/${item.id}/categories`) {
        this.$router.push(`/posts/${item.id}/categories`);
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
      this.$router.push({ name: "LoginPage" });
    },
    logIn() {
      if (this.$route.name !== "LoginPage") {
        this.$router.push({ name: "LoginPage" });
      } else {
        this.drawer = false;
      }
    },
    signIn() {
      if (this.$route.name !== "SignUpPage") {
        this.$router.push({ name: "SignUpPage" });
      } else {
        this.drawer = false;
      }
    },
  },
};
</script>
<style scoped>
</style>
