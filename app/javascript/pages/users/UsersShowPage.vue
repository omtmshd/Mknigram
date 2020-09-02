<template>
  <div>
    <v-card>
      <user-show :user="user" @set-follow="updateUser()"></user-show>
      <template>
        <v-tabs v-model="tabsKey" centered color="#43A047">
          <v-tab v-for="t in tabasItem" :key="t.index">{{ t }}</v-tab>
        </v-tabs>
      </template>

      <v-tabs-items v-model="tabsKey">
        <v-tab-item>
          <v-card-text v-if="user.posts.length === 0" class="subtitle-2 text-center">投稿はありません</v-card-text>

          <posts-index-image v-else :posts-data="user.posts" @update-posts="updateUser()"></posts-index-image>
        </v-tab-item>
        <v-tab-item>
          <v-card-text v-if="likesPosts.length === 0" class="subtitle-2 text-center">いいねした投稿はありません</v-card-text>

          <posts-index-image v-else :posts-data="likesPosts" @update-posts="updateLikes()"></posts-index-image>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";

import UserShow from "../../components/User/UserShow.vue";
import PostsIndexImage from "../../components/Post/PostsIndexImage.vue";

export default {
  components: {
    UserShow,
    PostsIndexImage,
  },
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
        posts: [],
      },
      tabsKey: null,
      tabasItem: ["投稿", "いいね"],
      likesPosts: [],
    };
  },
  mounted() {
    this.updateUser();
    this.updateLikes();
  },
  watch: { $route: "updateUser" },
  methods: {
    async setUser() {
      const res = await axios.get(
        `/api/v1/users/${this.$route.params.id}.json`
      );
      return res.data;
    },
    updateUser() {
      this.setUser().then((result) => {
        this.user = result;
      });
    },
    async setUserLikes() {
      const res = await axios.get(
        `/api/v1/likes/${this.$route.params.id}/posts.json`
      );
      return res.data;
    },
    updateLikes() {
      this.setUserLikes().then((result) => {
        this.likesPosts = result;
      });
    },
  },
};
</script>
<style scoped>
</style>
