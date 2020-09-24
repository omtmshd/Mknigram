<template>
  <v-hover v-slot:default="{ hover }">
    <v-card
      :elevation="hover ? 12 : 2"
      :class="{ 'on-hover': hover }"
      @click="clickLists"
      :width="cardWidth"
      class="mx-auto my-2"
    >
      <v-img
        v-if="lists.length > 0"
        :src="post.post_image.url"
        height="80px"
        :width="cardWidth"
        :gradient="gradientColor"
        class="white--text align-center"
      >
        <v-card-subtitle class="py-0 white--text text-sm-caption">{{lists.length}} 品</v-card-subtitle>
        <v-card-title class="py-0">{{listFolder.name}}</v-card-title>
        <template v-if="hover">
          <v-btn v-if="listStatus" icon dark right absolute top>
            <v-icon>mdi-minus</v-icon>
          </v-btn>
          <v-btn v-else icon dark right absolute top>
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </template>
      </v-img>
      <v-img
        v-else
        height="80px"
        :width="cardWidth"
        :gradient="gradientColor"
        class="white--text align-center"
      >
        <v-card-subtitle class="py-0 white--text text-sm-caption">{{lists.length}} 品</v-card-subtitle>
        <v-card-title class="py-0">{{listFolder.name}}</v-card-title>
        <template v-if="hover">
          <v-btn v-if="listStatus" icon dark right absolute top>
            <v-icon>mdi-minus</v-icon>
          </v-btn>
          <v-btn v-else icon dark right absolute top>
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </template>
      </v-img>
    </v-card>
  </v-hover>
</template>
<script>
import axios from "axios";

export default {
  props: {
    listFolder: {
      id: "",
      name: "",
    },
  },
  data() {
    return {
      lists: [],
      post: {
        post_image: {
          url: "",
        },
      },
    };
  },
  mounted() {
    this.setLists();
  },
  methods: {
    async setLists() {
      await axios
        .get(`/api/v1/lists/${this.listFolder.id}`)
        .then(({ data }) => {
          this.lists = data;
        });
      this.getPost();
    },
    getPost() {
      axios.get(`/api/v1/posts/${this.lists[0].post_id}`).then(({ data }) => {
        this.post = data;
      });
    },
    clickLists() {
      if (this.listStatus) {
        this.deleteToLists();
      } else {
        this.addToLists();
      }
    },
    // list モデル作成
    async addToLists() {
      let formData = new FormData();
      formData.append("list[post_id]", this.$route.params.post_id);
      formData.append("list[list_folder_id]", this.listFolder.id);
      const res = await axios
        .post("/api/v1/lists", formData, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      if (res.status !== 201) {
        process.exit();
      }
      this.setLists();
    },
    // listモデル 削除
    async deleteToLists() {
      const list = this.lists.find((list) => {
        return Number(list.post_id) === Number(this.$route.params.post_id);
      });
      const res = await axios
        .delete(`/api/v1/lists/${list.id}`, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      if (res.status !== 200) {
        process.exit();
      }
      this.setLists();
    },
  },
  computed: {
    // リストに追加しているか
    listStatus() {
      const result = this.lists.find((list) => {
        return Number(list.post_id) === Number(this.$route.params.post_id);
      });
      return Boolean(result);
    },
    // リストのグラーデーションカラー
    gradientColor() {
      if (this.listStatus) {
        return "to bottom, rgba(40,160,90,.7), rgba(40,160,90,.7)";
      } else {
        return "to right top, rgba(0,0,0,.8) 10%, rgba(0,0,0,.3)";
      }
    },
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "300";
        case "sm":
          return "300";
        case "md":
          return "400";
        case "lg":
          return "400";
        case "xl":
          return "400";
      }
    },
  },
};
</script>
<style scoped>
.v-btn--absolute.v-btn--top {
  top: 20px;
}
</style>
