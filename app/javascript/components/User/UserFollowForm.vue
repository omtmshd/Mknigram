<template>
  <v-row justify="end" align="center" no-gutters>
    <v-col cols="6">
      <v-btn
        color="#43A047"
        class="text-decoration-underline"
        text
        @click.stop="showFollowing()"
      >フォロー中 ({{ followingCount }})</v-btn>
    </v-col>
    <v-col cols="6">
      <v-btn
        color="#43A047"
        class="text-decoration-underline"
        text
        @click.stop="showFollowers()"
      >フォロワー ({{ followersCount }})</v-btn>
    </v-col>
    <v-col cols="12">
      <template v-if="otherUser">
        <v-row justify="end" align="center" no-gutters>
          <v-col cols="7" md="6" lg="6" xl="6">
            <v-chip v-if="followedStatus" class="ma-2" x-small>フォローされています</v-chip>
          </v-col>
          <v-col cols="5" md="6" lg="6" xl="6">
            <v-btn
              v-if="followingStatus"
              block
              color="#FFF176"
              rounded
              small
              @click.stop="userUnfollow()"
            >フォロー解除</v-btn>

            <v-btn v-else block color="#FFF176" rounded small @click.stop="userFollow()">フォローする</v-btn>
          </v-col>
        </v-row>
      </template>
    </v-col>
  </v-row>
</template>
<script>
import axios from "axios";

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
    otherUser() {
      return this.currentUser !== null && this.currentUser.id !== this.userId;
    },
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
  mounted() {
    this.setUser();
  },
  watch: { $route: "setUser" },
  methods: {
    // ユーザーデータ取得
    async setUser() {
      const res = await axios.get(
        `/api/v1/users/${this.userId}/follow_data.json`
      );
      this.user = res.data;
    },
    // フォローする
    async userFollow() {
      await axios.post(
        "/api/v1/relationships.json",
        {
          followed_id: this.userId,
        },
        {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        }
      );

      this.setUser();
      this.$emit("set-follow");
    },
    // フォロー解除
    async userUnfollow() {
      await axios.delete(`/api/v1/relationships/${this.userId}.json`, {
        headers: {
          "access-token": localStorage.getItem("access-token"),
          uid: localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
        },
      });

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
