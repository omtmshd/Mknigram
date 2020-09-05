<template>
  <v-row justify="end" align="center" no-gutters>
    <v-col cols="6">
      <v-btn
        color="#43A047"
        class="text-decoration-underline"
        text
        @click.stop="$emit('show-following')"
      >フォロー中 ({{ followingCount }})</v-btn>
    </v-col>
    <v-col cols="6">
      <v-btn
        color="#43A047"
        class="text-decoration-underline"
        text
        @click.stop="$emit('show-followers')"
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
              class="white--text"
              color="#37474F"
              rounded
              small
              @click.stop="userUnfollow"
            >フォロー解除</v-btn>

            <v-btn
              v-else
              block
              color="#37474F"
              class="white--text"
              rounded
              small
              @click.stop="userFollow"
            >フォローする</v-btn>
          </v-col>
        </v-row>
      </template>
    </v-col>
  </v-row>
</template>
<script>
import axios from "axios";

export default {
  props: {
    userId: "",
    currentUser: {},
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
    setUser() {
      axios.get(`/api/v1/users/${this.userId}/follow_data`).then(({ data }) => {
        this.user = data;
      });
    },
    // フォローする
    async userFollow() {
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
      this.$emit("user-reset");
    },
    // フォロー解除
    async userUnfollow() {
      await axios.delete(`/api/v1/relationships/${this.userId}`, {
        headers: {
          "access-token": localStorage.getItem("access-token"),
          uid: localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
        },
      });
      this.setUser();
      this.$emit("user-reset");
    },
  },
};
</script>
<style scoped>
</style>
