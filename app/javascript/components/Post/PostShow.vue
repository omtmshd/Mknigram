<template>
  <div id="overlay" @click.prevent="clickEvent">
    <div id="content">
      <v-container>
        <v-card class="mx-auto" max-width="400" min-width="300">
          <v-container>
            <v-img :src="post.post_image.url" aspect-ratio="1.7" contain></v-img>
            <v-card-title>{{ post.title }}</v-card-title>
            <v-breadcrumbs :items="post.categories" text="name">
              <template v-slot:item="{ item }">
                <v-breadcrumbs-item>{{ item.name }}</v-breadcrumbs-item>
              </template>
            </v-breadcrumbs>
            <v-card-text>{{ post.body }}</v-card-text>
            <v-divider class="mx-4"></v-divider>
            <v-card-actions>
              <v-avatar size="62" @click.stop="showUser(post.user.id)">
                <img v-if="post.user.profile_image.url != null" :src="post.user.profile_image.url" />
                <v-icon v-else size="62" color="#FFEE58" dark>mdi-account-circle</v-icon>
              </v-avatar>
              <v-spacer></v-spacer>
              <template v-if="currentUser.id === post.user.id">
                <v-btn icon @click.stop="showModal = true">
                  <v-icon>mdi-delete</v-icon>
                </v-btn>
                <modal
                  v-if="showModal"
                  @cancel="showModal = false"
                  @ok="deletePost(); showModal = false;"
                >
                  <div slot="body">本当に削除しますか？</div>
                </modal>
                <v-btn icon @click.stop="editPost()">
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </template>
              <like-button :post-id="post.id" :user-id="currentUser.id"></like-button>
            </v-card-actions>
          </v-container>
        </v-card>
      </v-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";

import Modal from "../../components/Post/Modal.vue";
import LikeButton from "../../components/Like/LikeButton.vue";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  components: {
    Modal,
    LikeButton,
  },
  props: { post: {} },
  data() {
    return {
      showModal: false,
      errors: "",
    };
  },
  methods: {
    deletePost() {
      axios
        .delete(`/api/v1/posts/?post_id=${this.post.id}`)
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
    clickEvent() {
      this.$emit("from-child");
    },
    showUser(i) {
      this.$router.push({
        name: "UsersShowPage",
        params: { id: i },
      });
    },
    editPost() {
      this.$router.push({
        name: "PostsEditPage",
        params: { id: this.post.id },
      });
    },
  },
};
</script>

<style scoped>
</style>
