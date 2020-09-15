<template>
  <v-container>
    <v-dialog v-model="dialog" width="350">
      <user-edit-modal @close="dialogClose"></user-edit-modal>
    </v-dialog>
    <v-card flat class="mx-auto" :width="cardWidth" color="rgba(255,255,255,.85)">
      <v-container>
        <v-row justify="center" align="center">
          <v-col cols="4">
            <v-avatar size="62" @click=" showUser">
              <img v-if="user.profile_image.url !== null" :src="user.profile_image.url" />
              <v-icon v-else size="62" color="#90A4AE" dark>mdi-account-circle</v-icon>
            </v-avatar>
          </v-col>
          <v-col cols="7">
            <strong>{{ user.name}}</strong>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <user-follow-form
          :user-page="true"
          :user-id="this.$route.params.id"
          :current-user="currentUser"
          @show-following="$emit('show-following')"
          @show-followers="$emit('show-followers')"
        ></user-follow-form>
        <v-card-text>{{ user.profile }}</v-card-text>
        <template v-if="currentUser !== null && currentUser.id === user.id">
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn icon @click.stop="editUser">
              <v-icon color="#263238">mdi-account-edit</v-icon>
            </v-btn>
          </v-card-actions>
        </template>
      </v-container>
    </v-card>
  </v-container>
</template>
<script>
import axios from "axios";

import UserFollowForm from "../follow/UserFollowForm.vue";
import UserEditModal from "../User/UserEditModal.vue";

export default {
  components: {
    UserFollowForm,
    UserEditModal,
  },
  props: {
    user: {
      profile_image: {
        url: "",
      },
    },
    currentUser: {},
  },
  data() {
    return {
      dialog: false,
    };
  },
  methods: {
    editUser() {
      this.dialog = true;
    },
    dialogClose() {
      this.dialog = false;
      this.$emit("user-reset");
    },
    showUser() {
      if (this.$route.path !== `/users/${this.user.id}/`) {
        this.$router.push({
          name: "UserPostsPage",
          params: { id: this.user.id },
        });
      }
    },
  },
  computed: {
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "330";
        case "sm":
          return "400";
        case "md":
          return "400";
        case "lg":
          return "400";
        case "xl":
          return "400";
      }
    },
  },
};
</script>
<style scoped>
</style>
