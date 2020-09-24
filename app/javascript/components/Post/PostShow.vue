<template>
  <v-card max-width="560">
    <v-card-actions class="py-0">
      <v-avatar size="36" @click.stop="showUser">
        <img v-if="post.user.profile_image.url !== null" :src="post.user.profile_image.url" />
        <v-icon v-else size="36" color="#90A4AE" dark>mdi-account-circle</v-icon>
      </v-avatar>

      <span class="text-xs-caption">{{post.user.name}}</span>

      <v-spacer></v-spacer>

      <list-button :user-id="currentUser.id"></list-button>

      <like-button :user-id="currentUser.id"></like-button>
    </v-card-actions>

    <v-card-text :style="cardHeight" class="pa-0">
      <v-img
        :src="post.post_image.url"
        aspect-ratio="1.2"
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
        <template v-if="currentUser.id === post.user.id">
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

export default {
  components: {
    LikeButton,
    ListButton,
    PostDeleteModal,
    CategoryList,
  },
  props: {
    post: {
      id: "",
      title: "",
      body: "",
      post_image: {
        url: "",
      },
      user: {
        profile_image: {
          url: "",
        },
      },
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
    showUser() {
      if (this.$route.path !== `/users/${this.post.user.id}/posts`) {
        this.$router.push({
          name: "UserPostsPage",
          params: { id: this.post.user.id },
        });
      }
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
          return "max-height: 500px";
        case "sm":
          return "max-height: 600px";
        case "md":
          return "max-height: 700px";
        case "lg":
          return "max-height: 700px";
        case "xl":
          return "max-height: 700px";
      }
    },
  },
};
</script>

<style scoped>
</style>
