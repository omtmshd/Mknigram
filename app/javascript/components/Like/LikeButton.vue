<template>
  <div>
    <v-btn icon color="#FDD835" v-if="isLiked" @click.stop="deleteLike">
      <v-icon>mdi-thumb-up</v-icon>
    </v-btn>
    <v-btn icon v-else @click.stop="registerLike">
      <v-icon>mdi-thumb-up</v-icon>
    </v-btn>
    {{ count }}
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: ["postId", "userId"],
  data() {
    return {
      likeList: [],
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
  // Vueインスタンスの作成・初期化直後に実行される
  mounted() {
    this.fetchLikeByPostId().then((result) => {
      this.likeList = result;
    });
  },
  methods: {
    // rails側のindexアクション
    async fetchLikeByPostId() {
      const res = await axios.get(`/api/v1/likes/?post_id=${this.postId}`);
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    // rails側のcreateアクション
    async registerLike() {
      const res = await axios.post(
        "/api/v1/likes",
        { post_id: this.postId },
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
    },
    // rails側のdestroyアクション
    async deleteLike() {
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
