<template>
  <v-container>
    <v-card class="mx-auto" max-width="400" min-width="400">
      <v-container>
        <v-card-actions>
          <v-avatar size="62">
            <img v-if="user.profile_image.url != null" :src="user.profile_image.url" />
            <v-icon v-else size="62" color="yellow lighten-1" dark>mdi-account-circle</v-icon>
          </v-avatar>
          <v-spacer></v-spacer>
          <user-follow-form :user-id="this.$route.params.id" :follow-data="followData" @set="set()"></user-follow-form>
        </v-card-actions>
        <v-card-title>{{ user.name}}</v-card-title>
        <v-card-text>{{ user.profile }}</v-card-text>
        <template v-if="current_user.id === user.id">
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn icon @click.stop="editUser()">
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
          </v-card-actions>
        </template>
      </v-container>
    </v-card>
  </v-container>
</template>
<script>
import axios from "axios";

import UserFollowForm from "./UserFollowForm.vue";
import { currentUser } from "../../packs/mixins/currentUser";

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
    followData: {
      type: Number,
      required: false,
      default: -1,
    },
  },
  methods: {
    set() {
      this.$emit("set");
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
