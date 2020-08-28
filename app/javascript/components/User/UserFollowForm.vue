<template>
  <v-row justify="end" align="center" no-gutters>
    <v-col cols="6">
      <v-btn color="#2E7D32" text @click.stop="showFollowing()">フォロー中 &nbsp;({{ followingCount }})</v-btn>
    </v-col>
    <v-col cols="6">
      <v-btn color="#2E7D32" text @click.stop="showFollowers()">フォロワー &nbsp;({{ followersCount }})</v-btn>
    </v-col>
    <v-col cols="12">
      <template v-if="currentUser.id !== userId">
        <v-row justify="end" align="center" no-gutters>
          <v-col cols="7" md="6" lg="6" xl="6">
            <v-chip class="ma-2" x-small>フォローされています</v-chip>
          </v-col>
          <v-col cols="5" md="6" lg="6" xl="6">
            <v-btn
              v-if="followingStatus"
              block
              color="#FFF59D"
              rounded
              small
              @click.stop="userUnfollow()"
            >フォロー解除</v-btn>

            <v-btn v-else block color="#FFF59D" rounded small @click.stop="userFollow()">フォローする</v-btn>
          </v-col>
        </v-row>
      </template>
    </v-col>
  </v-row>
</template>
<script>
import axios from "axios";
import { csrfToken } from "rails-ujs";
axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  props: {
    userId: "",
  },
  data() {
    return {
      user: {
        following: [],
        followers: [],
      },
    };
  },
  computed: {
    followingCount() {
      return this.user.following.length;
    },
    followersCount() {
      return this.user.followers.length;
    },
    // フォロしているか
    followingStatus() {
      const result = this.user.followers.find((v) => {
        return v.id === this.currentUser.id;
      });
      return Boolean(result);
    },
    // フォローされているか
    followedStatus() {
      const result = this.user.following.find((v) => {
        return v.id === this.currentUser.id;
      });
      return Boolean(result);
    },
  },
  created() {
    this.setUser();
  },
  watch: { $route: "setUser" },
  methods: {
    // ユーザーデータ取得
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.userId}/follow_data.json`
      );
      this.user = res.data;
    },
    // フォローする
    userFollow: async function () {
      await axios.post("/api/v1/relationships.json", {
        followed_id: this.userId,
      });

      this.setUser();
      this.$emit("set-follow");
    },
    // フォロー解除
    userUnfollow: async function () {
      await axios.delete(`/api/v1/relationships/${this.userId}.json`);

      this.setUser();
      this.$emit("set-follow");
    },
    showFollowing() {
      this.$router.push({
        name: "UsersFollowingPage",
        params: { id: this.userId },
      });
    },
    showFollowers() {
      this.$router.push({
        name: "UsersFollowersPage",
        params: { id: this.userId },
      });
    },
  },
};
</script>
<style scoped>
</style>
