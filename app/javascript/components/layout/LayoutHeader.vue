<template>
  <header>
    <v-app-bar app color="#fcb69f" dark shrink-on-scroll :src="assetsImage">
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>

      <v-toolbar-title>Title</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <v-btn icon>
        <v-icon>mdi-heart</v-icon>
      </v-btn>

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" temporary app>
      <v-row class="fill-height" no-gutters>
        <v-navigation-drawer v-model="drawer" dark mini-variant mini-variant-width="56">
          <v-list-item class="px-2" link @click="usersShow()">
            <v-list-item-avatar>
              <v-img :src="currentUser.profile_image.url"></v-img>
            </v-list-item-avatar>
          </v-list-item>

          <v-divider></v-divider>

          <v-list dense nav>
            <v-list-item link @click="postsIndex()">
              <v-list-item-icon>
                <v-icon>mdi-home</v-icon>
              </v-list-item-icon>
            </v-list-item>

            <v-list-item link @click="usersEdit()">
              <v-list-item-icon>
                <v-icon>mdi-account-edit</v-icon>
              </v-list-item-icon>
            </v-list-item>

            <v-list-item link @click="usersFollowing()">
              <v-list-item-icon>
                <v-icon>mdi-account-arrow-right</v-icon>
              </v-list-item-icon>
            </v-list-item>

            <v-list-item link @click="usersFollowers()">
              <v-list-item-icon>
                <v-icon>mdi-account-arrow-left</v-icon>
              </v-list-item-icon>
            </v-list-item>

            <v-list-item link @click="usersIndex()">
              <v-list-item-icon>
                <v-icon>mdi-account-group</v-icon>
              </v-list-item-icon>
            </v-list-item>

            <v-list-item link>
              <v-list-item-icon>
                <v-icon>mdi-logout-variant</v-icon>
              </v-list-item-icon>
            </v-list-item>
          </v-list>
        </v-navigation-drawer>

        <v-list dense nav>
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
        </v-list>
      </v-row>
    </v-navigation-drawer>
  </header>
</template>
<script>
import AssetsImage from "../../../assets/images/background_9.jpg";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  data() {
    return {
      assetsImage: AssetsImage,
      drawer: false,
    };
  },
  methods: {
    postsNew() {
      this.$router.push({
        name: "PostsNewPage",
      });
    },
    postsIndex() {
      this.$router.push({ path: "/" });
    },
    usersEdit() {
      this.$router.push({
        name: "UsersEditPage",
        params: { id: this.currentUser.id },
      });
    },
    usersFollowers() {
      this.$router.push({
        name: "UsersFollowersPage",
        params: { id: this.currentUser.id },
      });
    },
    usersFollowing() {
      this.$router.push({
        name: "UsersFollowingPage",
        params: { id: this.currentUser.id },
      });
    },
    usersIndex() {
      this.$router.push({
        name: "UsersIndexPage",
      });
    },
    usersShow() {
      this.$router.push({
        name: "UsersShowPage",
        params: { id: this.currentUser.id },
      });
    },
  },
};
</script>
<style scoped>
</style>
