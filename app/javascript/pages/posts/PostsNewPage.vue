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
        post_image: null,
      },
      errors: "",
    };
  },
  methods: {
    createPost() {
      let formData = new FormData();
      formData.append("post[title]", this.post.title);
      formData.append("post[body]", this.post.body);
      formData.append("post[post_image]", this.post.post_image);
      axios
        .post("/api/v1/posts", formData)
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
