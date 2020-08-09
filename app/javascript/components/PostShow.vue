<template>
  <dl>
    <dt>ID</dt>
    <dd>{{ post.id }}</dd>
    <dt>Title</dt>
    <dd>{{ post.title }}</dd>
    <dt>Body</dt>
    <dd>{{ post.body }}</dd>
    <dt>Image</dt>
    <dd>{{ post.post_image }}</dd>
    <button @click="deleteTarget = post.id; showModal = true">Delete</button>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deletePost(); showModal = false;">
      <div slot="body">Are you sure?</div>
    </modal>
  </dl>
</template>

<script>
import axios from "axios";

import Modal from "./Modal.vue";

export default {
  components: {
    Modal,
  },
  data: function () {
    return {
      post: {},
      showModal: false,
      deleteTarget: -1,
      errors: "",
    };
  },
  mounted() {
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
