<template>
  <div>
    <router-link
      :to="{ name: 'UsersFollowingPage', params: { id: userId } }"
    >フォロー中{{ followingCount }}</router-link>
    <router-link
      :to="{ name: 'UsersFollowersPage', params: { id: userId } }"
    >フォロワー{{ followersCount }}</router-link>
    <template v-if="currentUser.id !== userId">
      <br />
      <div class="text-caption text-right" v-if="followedStatus">フォローされています</div>
      <v-card-actions>
        <br />
        <v-spacer></v-spacer>
        <template v-if="followingStatus">
          <v-btn text small @click.stop="userUnfollow()">フォロー解除</v-btn>
        </template>
        <template v-else>
          <v-btn text small @click.stop="userFollow()">フォローする</v-btn>
        </template>
      </v-card-actions>
    </template>
  </div>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  props: {
    userId: "",
    followData: {
      type: Number,
      required: false,
      default: -1,
    },
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
    this.setUser().then((result) => {
      this.user = result;
    });
  },
  methods: {
    // ユーザーデータ取得
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.userId}/following.json`
      );
      return res.data;
    },
    // フォローする
    userFollow: async function () {
      const res = await axios.post("/api/v1/relationships.json", {
        followed_id: this.userId,
        follower_id: this.currentUser.id,
      });
      this.setUser().then((result) => {
        this.user = result;
      });
      if (this.followData >= 0) {
        this.$emit("set");
      }
    },
    // フォロー解除
    userUnfollow: async function () {
      const res = await axios.delete(
        `/api/v1/relationships/${this.userId}.json`
      );
      this.setUser().then((result) => {
        this.user = result;
      });
      if (this.followData >= 0) {
        this.$emit("set");
      }
    },
  },
};
</script>
<style scoped>
</style>
