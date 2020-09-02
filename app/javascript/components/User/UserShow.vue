<template>
  <v-container>
    <v-card flat class="mx-auto" max-width="300" min-width="300">
      <v-container>
        <v-row justify="center" align="center">
          <v-col cols="4">
            <v-avatar size="62">
              <img v-if="user.profile_image.url !== null" :src="user.profile_image.url" />
              <v-icon v-else size="62" color="#90A4AE" dark>mdi-account-circle</v-icon>
            </v-avatar>
          </v-col>
          <v-col cols="7">
            <strong>{{ user.name}}</strong>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <user-follow-form :user-id="this.$route.params.id" @set-follow="setFollow()"></user-follow-form>
        <v-card-text>{{ user.profile }}</v-card-text>
        <template v-if="loginUser">
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn icon @click.stop="editUser()">
              <v-icon color="#FDD835">mdi-pencil</v-icon>
            </v-btn>
          </v-card-actions>
        </template>
      </v-container>
    </v-card>
  </v-container>
</template>
<script>
import axios from "axios";

import { currentUser } from "../../packs/mixins/currentUser";

import UserFollowForm from "./UserFollowForm.vue";

export default {
  mixins: [currentUser],
  components: {
    UserFollowForm,
  },
  props: {
    user: {
      profile_image: {
        url: "",
      },
      posts: [],
    },
  },
  computed: {
    loginUser() {
      return this.currentUser !== null && this.currentUser.id === this.user.id;
    },
  },
  methods: {
    setFollow() {
      this.$emit("set-follow");
    },
    editUser() {
      this.$router.push({
        name: "UsersEditPage",
        params: { id: this.user.id },
      });
    },
  },
};
</script>
<style scoped>
</style>
