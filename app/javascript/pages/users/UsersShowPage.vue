<template>
  <div>
    <v-dialog v-model="dialogFollowing" scrollable :width="dialogWidth">
      <user-following-modal :current-user="currentUser"></user-following-modal>
    </v-dialog>
    <v-dialog v-model="dialogFollowers" scrollable :width="dialogWidth">
      <user-followers-modal :current-user="currentUser"></user-followers-modal>
    </v-dialog>

    <v-card>
      <user-show
        :user="user"
        :current-user="currentUser"
        @show-following="dialogFollowing = true"
        @show-followers="dialogFollowers = true"
      ></user-show>

      <template>
        <v-tabs v-model="tabsKey" centered color="#43A047">
          <v-tab v-for="t in tabasItem" :key="t.index">{{ t }}</v-tab>
        </v-tabs>
      </template>

      <v-tabs-items v-model="tabsKey">
        <v-tab-item>
          <user-posts :current-user="currentUser"></user-posts>
        </v-tab-item>

        <v-tab-item>
          <like-posts :current-user="currentUser"></like-posts>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";
import { currentUser } from "../../packs/mixins/currentUser";

import UserShow from "../../components/User/UserShow.vue";
import UserFollowingModal from "../../components/User/UserFollowingModal.vue";
import UserFollowersModal from "../../components/User/UserFollowersModal.vue";
import UserPosts from "../../components/Post/UserPosts.vue";
import LikePosts from "../../components/Post/LikePosts.vue";

export default {
  mixins: [currentUser],
  components: {
    UserShow,
    UserFollowingModal,
    UserFollowersModal,
    UserPosts,
    LikePosts,
  },
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
      },

      tabsKey: null,
      tabasItem: ["投稿", "いいね"],

      dialogFollowing: false,
      dialogFollowers: false,
    };
  },
  mounted() {
    this.setUser();
  },
  watch: {
    $route: "setUser",
  },
  methods: {
    setUser() {
      axios.get(`/api/v1/users/${this.$route.params.id}`).then(({ data }) => {
        this.user = data;
      });
      this.dialogFollowing = this.dialogFollowers = false;
    },
  },
  computed: {
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "330";
        case "sm":
          return "400";
        case "md":
          return "600";
        case "lg":
          return "600";
        case "xl":
          return "600";
      }
    },
  },
};
</script>
<style scoped>
</style>
