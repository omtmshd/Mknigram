<template>
  <div>
    <p>ID</p>
    <p>{{ post.id }}</p>
    <p>Title</p>
    <p>{{ post.title }}</p>
    <p>Body</p>
    <p>{{ post.body }}</p>
    <p>Image</p>
    <p>{{ post.post_image }}</p>
    <p>
      <button @click="deleteTarget = post.id; showModal = true">Delete</button>
      <modal v-if="showModal" @cancel="showModal = false" @ok="deletePost(); showModal = false;">
        <div slot="body">Are you sure?</div>
      </modal>
    </p>
    <like-button :post-id="$route.params.id"></like-button>
  </div>
</template>

<script>
import axios from "axios";

import Modal from "../../components/Post/Modal.vue";
import LikeButton from "../../components/Like/LikeButton.vue";

export default {
  components: {
    Modal,
    LikeButton,
  },
  data() {
    return {
      post: {},
      showModal: false,
      deleteTarget: -1,
      errors: "",
    };
  },
  created() {
    axios
      .get(`/api/v1/posts/${this.$route.params.id}.json`)
      .then((response) => (this.post = response.data));
  },
  methods: {
    deletePost() {
      if (this.deleteTarget <= 0) {
        console.warn("deleteTarget should be grater than zero.");
        return;
      }

      axios
        .delete(`/api/v1/posts/${this.deleteTarget}`)
        .then((response) => {
          this.$router.push({ path: "/" });
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
