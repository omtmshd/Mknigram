<template>
  <div>
    <v-card color="rgba(255,255,255,0.85)" :width="imageWidth" class="mx-auto">
      <v-img
        :src="post.post_image.url"
        aspect-ratio="1.2"
        class="white--text align-end"
        gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
      >
        <v-card-title v-text="post.title"></v-card-title>
      </v-img>

      <v-card-text>
        <v-breadcrumbs :items="post.categories" text="name" class="px-0 py-1">
          <template v-slot:item="{ item }">
            <v-breadcrumbs-item>
              <v-btn
                small
                text
                class="px-0"
                color="#616161"
                @click.stop="categorySearch(item.id)"
              >{{ item.name }}</v-btn>
            </v-breadcrumbs-item>
          </template>
        </v-breadcrumbs>
        <p>{{ post.body }}</p>
      </v-card-text>

      <v-divider class="mx-4"></v-divider>

      <v-card-actions>
        <v-avatar size="42" @click.stop="showUser()">
          <img v-if="post.user.profile_image.url !== null" :src="post.user.profile_image.url" />
          <v-icon v-else size="42" color="#90A4AE" dark>mdi-account-circle</v-icon>
        </v-avatar>
        <span class="text--secondary">by. {{post.user.name}}</span>
        <v-spacer></v-spacer>
        <template v-if="currentUser !== null">
          <template v-if="currentUser.id === post.user.id">
            <v-btn icon @click.stop="showModal = true">
              <v-icon>mdi-delete</v-icon>
            </v-btn>
            <post-delete-modal
              v-if="showModal"
              @cancel="showModal = false"
              @ok="deletePost(); showModal = false;"
            >
              <div slot="body">本当に削除しますか？</div>
            </post-delete-modal>
            <v-btn icon @click.stop="editPost()">
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
          </template>
          <like-button :post-id="post.id" :user-id="currentUser.id"></like-button>
        </template>
      </v-card-actions>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";
import LikeButton from "../Like/LikeButton.vue";
import PostDeleteModal from "./PostDeleteModal.vue";

export default {
  components: { LikeButton, PostDeleteModal },
  props: {
    post: {},
    currentUser: {},
  },
  computed: {
    imageWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "300";
        case "sm":
          return "400";
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
      if (this.$route.path !== `/users/${this.post.user.id}/`) {
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
    categorySearch(i) {
      if (this.$route.path !== `/posts/${i}/categories`) {
        this.$router.push(`/posts/${i}/categories`);
      }
    },
  },
};
</script>

<style scoped>
.col {
  padding: 0.1em;
}
</style>
