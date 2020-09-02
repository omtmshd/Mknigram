<template>
  <div>
    <div v-for="post in postsData" :key="post.index">
      <v-card class="mx-auto" :width="imageWidth">
        <v-img
          :src="post.post_image.url"
          aspect-ratio="1.2"
          class="white--text align-end"
          gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
        >
          <v-card-title v-text="post.title"></v-card-title>
        </v-img>

        <v-breadcrumbs :items="post.categories" text="name">
          <template v-slot:item="{ item }">
            <v-breadcrumbs-item>{{ item.name }}</v-breadcrumbs-item>
          </template>
        </v-breadcrumbs>

        <v-card-text>{{ post.body }}</v-card-text>

        <v-divider class="mx-4"></v-divider>

        <v-card-actions>
          <v-avatar size="56" @click.stop="showUser(post.user.id)">
            <img v-if="post.user.profile_image.url !== null" :src="post.user.profile_image.url" />
            <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
          </v-avatar>
          <v-spacer></v-spacer>
          <template v-if="currentUser !== null">
            <template v-if="currentUser.id === post.user.id">
              <v-btn icon @click.stop="showModal = true">
                <v-icon>mdi-delete</v-icon>
              </v-btn>
              <post-delete-modal
                v-if="showModal"
                @cancel="showModal = false"
                @ok="deletePost(post.id); showModal = false;"
              >
                <div slot="body">本当に削除しますか？</div>
              </post-delete-modal>
              <v-btn icon @click.stop="editPost(post.id)">
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>
            <like-button :post-id="post.id" :user-id="currentUser.id"></like-button>
          </template>
        </v-card-actions>
      </v-card>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import LikeButton from "../Like/LikeButton.vue";
import PostDeleteModal from "./PostDeleteModal.vue";
import PostShowModal from "./PostShowModal.vue";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  components: { LikeButton, PostShowModal, PostDeleteModal },
  props: {
    postsData: {
      type: Array,
      default: [],
    },
  },
  computed: {
    imageWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "300";
        case "sm":
          return "560";
        case "md":
          return "560";
        case "lg":
          return "560";
        case "xl":
          return "560";
      }
    },
  },
  data() {
    return {
      errors: "",
      showModal: false,
    };
  },
  methods: {
    updatePosts() {
      this.$emit("update-posts");
    },
    deletePost(i) {
      axios
        .delete(`/api/v1/posts/${i}`, {
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
    showUser(i) {
      this.$router.push({
        name: "UsersShowPage",
        params: { id: i },
      });
    },
    editPost(i) {
      this.$router.push({
        name: "PostsEditPage",
        params: { id: i },
      });
    },
  },
};
</script>

<style scoped>
.col {
  padding: 0.1em;
}
</style>
