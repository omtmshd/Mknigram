<template>
  <post-form :post="post" :errors="errors" @submit="createPost"></post-form>
</template>

<script>
import axios from "axios";
import PostForm from "../../components/Post/PostForm.vue";

export default {
  components: { PostForm },
  data() {
    return {
      post: {
        title: "",
        body: "",
        post_image: String,
        category_ids: [],
        categories: [],
      },
      errors: "",
    };
  },
  methods: {
    createPost() {
      // フォームデータ
      let formData = new FormData();
      formData.append("post[title]", this.post.title);
      formData.append("post[body]", this.post.body);
      formData.append("post[post_image]", this.post.post_image);
      // メインが選択済みである場合、代入
      if (this.post.categories[0].id > 0) {
        this.post.category_ids = [this.post.categories[0].id];
        // サブのidがメインより大きい場合、代入
        if (this.post.categories[1].id > this.post.categories[0].id) {
          this.post.category_ids = [
            this.post.categories[0].id,
            this.post.categories[1].id,
          ];
          // サブ2のidがサブより大きい場合、代入
          if (this.post.categories[2].id > this.post.categories[1].id) {
            this.post.category_ids = [
              this.post.categories[0].id,
              this.post.categories[1].id,
              this.post.categories[2].id,
            ];
          }
        }
        // 配列をまとめる
        this.post.category_ids.forEach((category_id, index) => {
          formData.append("post[category_ids][]", category_id);
        });
        // 有効なデータが無い場合、空配列
      } else {
        formData.append("post[category_ids][]", []);
      }
      axios
        .post("/api/v1/posts", formData, {
          headers: {
            "content-type": "multipart/form-data",
          },
        })
        .then((response) => {
          let p = response.data;
          this.$router.push({
            name: "PostsShowPage",
            params: { id: p.id },
          });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  },
};
</script>

<style scoped>
</style>
