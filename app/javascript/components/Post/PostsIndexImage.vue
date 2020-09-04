<template>
  <div>
    <post-show-modal
      :post="post"
      :current-user="currentUser"
      v-show="showPost === post.id"
      @from-child="closeModal"
      @update-posts="$emit('update-posts')"
    ></post-show-modal>
    <v-col>
      <v-card @click.prevent="openModal()" class="mx-auto" :width="imageWidth" :height="imageHight">
        <v-img
          :src="post.post_image.url"
          aspect-ratio="1.2"
          gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
        ></v-img>
      </v-card>
    </v-col>
  </div>
</template>
<script>
import LikeButton from "../Like/LikeButton.vue";
import PostShowModal from "./PostShowModal.vue";

export default {
  components: { LikeButton, PostShowModal },
  props: {
    post: {},
    currentUser: {},
  },
  data() {
    return {
      page: 1, //現在のページ
      pageSize: 30, //1ページに入るpostの数
      length: 0, //ページ数
      showPost: -1,
    };
  },
  computed: {
    imageWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "108";
        case "sm":
          return "216";
        case "md":
          return "336";
        case "lg":
          return "336";
        case "xl":
          return "336";
      }
    },
    imageHight() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "90";
        case "sm":
          return "180";
        case "md":
          return "280";
        case "lg":
          return "280";
        case "xl":
          return "280";
      }
    },
  },
  methods: {
    openModal() {
      this.showPost = this.post.id;
    },
    closeModal() {
      this.showPost = -1;
    },
  },
};
</script>

<style scoped>
.col {
  padding: 0.1em;
}
</style>
