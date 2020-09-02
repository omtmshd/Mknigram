<template>
  <header>
    <v-app-bar app dark shrink-on-scroll :src="assetsImage" color="rgba(0,0,0,.5)">
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>

      <v-toolbar-title>Mknigram</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-toolbar-title v-if="currentUser === null">ログインしてください</v-toolbar-title>

      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <v-btn icon>
        <v-icon>mdi-heart</v-icon>
      </v-btn>

      <v-btn icon @click="postsNew()">
        <v-icon>mdi-tooltip-edit-outline</v-icon>
      </v-btn>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" temporary app>
      <v-row class="fill-height" no-gutters>
        <v-navigation-drawer v-model="drawer" dark mini-variant mini-variant-width="56">
          <template v-if="currentUser !== null">
            <v-list-item class="px-2" link @click="usersShow()">
              <v-list-item-avatar>
                <v-img
                  v-if="currentUser.profile_image.url !== null"
                  :src="currentUser.profile_image.url"
                ></v-img>
                <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
              </v-list-item-avatar>
            </v-list-item>

            <v-divider></v-divider>

            <v-list nav>
              <v-list-item link @click="postsIndex()">
                <v-list-item-icon>
                  <v-icon color="#FFF176">mdi-home</v-icon>
                </v-list-item-icon>
              </v-list-item>

              <v-list-item link @click="usersEdit()">
                <v-list-item-icon>
                  <v-icon color="#FFF176">mdi-account-edit</v-icon>
                </v-list-item-icon>
              </v-list-item>

              <v-list-item link @click="usersFollowing()">
                <v-list-item-icon>
                  <v-icon color="#FFF176">mdi-account-arrow-right</v-icon>
                </v-list-item-icon>
              </v-list-item>

              <v-list-item link @click="usersFollowers()">
                <v-list-item-icon>
                  <v-icon color="#FFF176">mdi-account-arrow-left</v-icon>
                </v-list-item-icon>
              </v-list-item>

              <v-list-item link @click="usersIndex()">
                <v-list-item-icon>
                  <v-icon color="#FFF176">mdi-account-group</v-icon>
                </v-list-item-icon>
              </v-list-item>

              <v-list-item link @click.stop="showModal = true">
                <v-list-item-icon>
                  <v-icon color="#FFF176">mdi-logout-variant</v-icon>
                </v-list-item-icon>
              </v-list-item>
            </v-list>
          </template>
          <template v-else>
            <v-list-item link @click="postsIndex()">
              <v-list-item-icon>
                <v-icon color="#FFF176">mdi-home</v-icon>
              </v-list-item-icon>
            </v-list-item>
            <v-list-item link @click="usersIndex()">
              <v-list-item-icon>
                <v-icon color="#FFF176">mdi-account-group</v-icon>
              </v-list-item-icon>
            </v-list-item>
            <v-list-item link @click="logIn()">
              <v-list-item-icon>
                <v-icon color="#FFF176">mdi-login-variant</v-icon>
              </v-list-item-icon>
            </v-list-item>
          </template>
        </v-navigation-drawer>

        <v-list nav>
          <template v-if="currentUser !== null">
            <v-list-item link @click="postsNew()">
              <v-list-item-content>
                <v-list-item-title>レシピを書く</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item link>
              <v-list-item-content>
                <v-list-item-title>いいねしたレシピ</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item link>
              <v-list-item-content>
                <v-list-item-title>カテゴリーから探す</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>
          <template v-else>
            <v-list-item link @click="logIn()">
              <v-list-item-content>
                <v-list-item-title>ログイン</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item link @click="signIn()">
              <v-list-item-content>
                <v-list-item-title>新規登録</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>
        </v-list>
      </v-row>
    </v-navigation-drawer>
    <user-logout-modal
      v-if="showModal"
      @cancel="showModal = false"
      @ok="logOut(); showModal = false;"
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
    };
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
    usersFollowers() {
      if (this.$route.path !== `/users/${this.currentUser.id}/followers`) {
        this.$router.push({
          name: "UsersFollowersPage",
          params: { id: this.currentUser.id },
        });
      } else {
        this.drawer = false;
      }
    },
    usersFollowing() {
      if (this.$route.path !== `/users/${this.currentUser.id}/following`) {
        this.$router.push({
          name: "UsersFollowingPage",
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
    async logOut() {
      await axios
        .delete("/api/v1/auth/sign_out.json", {
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
