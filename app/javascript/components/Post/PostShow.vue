<template>
  <v-card max-width="560">
    <v-card-actions class="py-0">
      <user-avatar :user-id="post.user_id"></user-avatar>

      <v-spacer></v-spacer>

      <list-button :user-id="currentUser.id"></list-button>

      <like-button :user-id="currentUser.id"></like-button>
    </v-card-actions>

    <v-card-text :style="cardHeight" class="pa-0">
      <v-img
        :src="post.post_image.url"
        width="100%"
        class="white--text align-end"
        gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
      >
        <v-card-title v-text="post.title"></v-card-title>
      </v-img>

      <v-card-text>
        <category-list></category-list>

        <v-divider class="mx-4"></v-divider>

        <p>{{ post.body }}</p>
      </v-card-text>
      <template v-if="currentUser.id > 0">
        <template v-if="currentUser.id === post.user_id">
          <v-btn icon @click.stop="showModal = true">
            <v-icon>mdi-delete</v-icon>
          </v-btn>

          <post-delete-modal
            v-if="showModal"
            @cancel="showModal = false"
            @ok="deletePost; showModal = false;"
          >
            <div slot="body">本当に削除しますか？</div>
          </post-delete-modal>

          <v-btn icon @click.stop="editPost">
            <v-icon>mdi-pencil</v-icon>
          </v-btn>
        </template>
      </template>
    </v-card-text>
  </v-card>
</template>
<script>
import axios from "axios";

import LikeButton from "../Like/LikeButton.vue";
import ListButton from "../List/ListButton.vue";
import PostDeleteModal from "./PostDeleteModal.vue";
import CategoryList from "../Category/CategoryList.vue";
import UserAvatar from "../User/UserAvatar.vue";

export default {
  components: {
    LikeButton,
    ListButton,
    PostDeleteModal,
    CategoryList,
    UserAvatar,
  },
  props: {
    post: {
      id: "",
      title: "",
      body: "",
      post_image: {
        url: "",
      },
      user_id: "",
    },
    currentUser: {},
  },
  data() {
    return {
      errors: "",
      showModal: false,
    };
  },
  methods: {
    deletePost() {
      axios
        .delete(`/api/v1/posts/${this.post.id}`, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((response) => {
          this.$emit("update-posts");
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    editPost() {
      this.$router.push({
        name: "PostsEditPage",
        params: { id: this.post.id },
      });
    },
  },
  computed: {
    cardHeight() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "max-height: 700px";
        case "sm":
          return "max-height: 800px";
        default:
          return "max-height: 900px";
      }
    },
  },
};
</script>

<style scoped>
</style>
