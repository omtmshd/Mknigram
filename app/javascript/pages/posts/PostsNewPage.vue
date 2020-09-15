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
      this.post.categories.forEach((category, index) => {
        formData.append("post[category_ids][]", category.id);
      });
      axios
        .post("/api/v1/posts", formData, {
          headers: {
            "content-type": "multipart/form-data",
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((response) => {
          this.$router.push({
            path: "/",
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
