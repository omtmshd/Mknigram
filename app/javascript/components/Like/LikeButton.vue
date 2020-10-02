<template>
  <div>
    <v-btn text color="#E53935" v-if="isLiked" @click.stop="deleteLike">
      <v-icon medium>mdi-heart-box</v-icon>
      {{ count }}
    </v-btn>
    <v-btn text v-else @click.stop="registerLike">
      <v-icon medium>mdi-heart-box</v-icon>
      {{ count }}
    </v-btn>
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
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: ["userId"],
  data() {
    return {
      likeList: [],
      snackbar: false,
    };
  },
  computed: {
    count() {
      return this.likeList.length;
    },
    isLiked() {
      if (this.likeList.length === 0) {
        return false;
      }
      return Boolean(this.findLikeId());
    },
  },
  mounted() {
    this.fetchLikeByPostId().then((result) => {
      this.likeList = result;
    });
  },
  methods: {
    // rails側のindexアクション
    async fetchLikeByPostId() {
      const res = await axios.get(
        `/api/v1/likes/?post_id=${this.$route.params.post_id}`
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    // rails側のcreateアクション
    async registerLike() {
      if (this.userId > 0) {
        const res = await axios.post(
          "/api/v1/likes",
          { post_id: this.$route.params.post_id },
          {
            headers: {
              "access-token": localStorage.getItem("access-token"),
              uid: localStorage.getItem("uid"),
              client: localStorage.getItem("client"),
            },
          }
        );
        if (res.status !== 201) {
          process.exit();
        }
        this.fetchLikeByPostId().then((result) => {
          this.likeList = result;
        });
      } else {
        this.snackbar = true;
      }
    },
    // rails側のdestroyアクション
    async deleteLike() {
      if (this.userId > 0) {
        const likeId = this.findLikeId();
        const res = await axios.delete(`/api/v1/likes/${likeId}`, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        });
        if (res.status !== 200) {
          process.exit();
        }
        this.likeList = this.likeList.filter((n) => n.id !== likeId);
      } else {
        this.snackbar = true;
      }
    },
    // いいねしているlikeモデルのidを返す
    findLikeId() {
      const like = this.likeList.find((like) => {
        return like.user_id === this.userId;
      });
      if (like) {
        return like.id;
      }
    },
  },
};
</script>
