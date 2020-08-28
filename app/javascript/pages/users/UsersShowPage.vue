<template>
  <div>
    <user-show :user="user" @set-follow="updateUser()"></user-show>
    <posts-index :posts-data="user.posts" @update-posts="updateUser()"></posts-index>
  </div>
</template>
<script>
import axios from "axios";
import { csrfToken } from "rails-ujs";
axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

import UserShow from "../../components/User/UserShow.vue";
import PostsIndex from "../../components/Post/PostsIndex.vue";

export default {
  components: {
    UserShow,
    PostsIndex,
  },
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
        posts: [],
      },
    };
  },
  created() {
    this.updateUser();
  },
  watch: { $route: "updateUser" },
  methods: {
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.$route.params.id}.json`
      );
      return res.data;
    },
    updateUser() {
      this.setUser().then((result) => {
        this.user = result;
      });
    },
  },
};
</script>
<style scoped>
</style>
