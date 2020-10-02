<template>
  <v-container>
    <v-dialog v-model="dialog" width="350">
      <user-edit-modal @close="dialogClose" :user="user"></user-edit-modal>
    </v-dialog>
    <v-list color="rgba(255,255,255,0)">
      <v-list-item two-line :link="false">
        <v-list-item-avatar :size="avatarSize">
          <img v-if="user.profile_image.url !== null" :src="user.profile_image.url" />
          <v-icon v-else :size="avatarSize" color="#90A4AE" dark>mdi-account-circle</v-icon>
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>
            {{ user.name }}
            <v-btn v-if="currentUser.id === user.id" icon @click.stop="editUser">
              <v-icon color="#263238">mdi-account-edit</v-icon>
            </v-btn>
          </v-list-item-title>
          <v-list-item-subtitle>
            <user-follow-form
              :user-page="true"
              :user-id="this.$route.params.id"
              :current-user="currentUser"
              @show-following="$emit('show-following')"
              @show-followers="$emit('show-followers')"
            ></user-follow-form>
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>{{user.profile}}</v-list-item-content>
      </v-list-item>
    </v-list>
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
  },
  computed: {
    avatarSize() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "70";
        case "sm":
          return "80";
        default:
          return "100";
      }
    },
  },
};
</script>
<style scoped>
</style>
