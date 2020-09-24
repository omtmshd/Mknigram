<template>
  <span>
    <v-btn
      v-if="userPage"
      color="#00ACC1"
      class="text-decoration-underline px-1"
      text
      small
      @click.stop="$emit('show-following')"
    >フォロー中 ({{ followingCount }})</v-btn>

    <v-btn
      v-if="userPage"
      color="#00ACC1"
      class="text-decoration-underline px-1"
      text
      small
      @click.stop="$emit('show-followers')"
    >フォロワー ({{ followersCount }})</v-btn>

    <template v-if="Number(currentUser.id) !== Number(userId)">
      <v-row justify="end" align="center" no-gutters>
        <v-chip v-if="followedStatus" class="ma-0" x-small>フォローされています</v-chip>

        <v-btn
          v-if="followingStatus"
          class="white--text"
          color="#37474F"
          rounded
          small
          @click.stop="userUnfollow"
        >フォロー解除</v-btn>

        <v-btn
          v-else
          color="#37474F"
          class="white--text"
          rounded
          small
          @click.stop="userFollow"
        >フォローする</v-btn>
      </v-row>
    </template>
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
  </span>
</template>
<script>
import axios from "axios";

export default {
  props: {
    userId: "",
    currentUser: {},
    userPage: true,
  },
  data() {
    return {
      user: {
        following: [],
        followers: [],
      },
      snackbar: false,
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
  mounted() {
    this.setUser();
  },
  watch: { $route: "setUser" },
  methods: {
    // ユーザーデータ取得
    setUser() {
      axios.get(`/api/v1/users/${this.userId}/follow_data`).then(({ data }) => {
        this.user = data;
      });
    },
    // フォローする
    async userFollow() {
      if (this.currentUser.id > 0) {
        await axios.post(
          "/api/v1/relationships",
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
      } else {
        this.snackbar = true;
      }
    },
    // フォロー解除
    async userUnfollow() {
      if (this.currentUser.id > 0) {
        await axios.delete(`/api/v1/relationships/${this.userId}`, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        });
        this.setUser();
      } else {
        this.snackbar = true;
      }
    },
  },
};
</script>
<style scoped>
</style>
