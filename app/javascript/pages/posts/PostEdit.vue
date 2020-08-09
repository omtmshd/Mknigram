<template>
  <post-form :post="post" :errors="errors" @submit="updatePost"></post-form>
</template>

<script>
import axios from "axios";
import PostForm from "../../components/Post/PostForm.vue";

export default {
  components: { PostForm },
  data() {
    return {
      post: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get(`/api/v1/posts/${this.$route.params.id}.json`)
      .then((response) => (this.post = response.data));
  },
  methods: {
    updatePost: function () {
      let formData = new FormData();
      formData.append("post[title]", this.post.title);
      formData.append("post[body]", this.post.body);
      // まだ画像編集できない
      // formData.append("post[post_image]", this.post.post_image);
      axios
        .patch(`/api/v1/posts/${this.post.id}`, formData)
        .then((response) => {
          this.$router.push({
            name: "PostShow",
            params: { id: this.post.id },
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
