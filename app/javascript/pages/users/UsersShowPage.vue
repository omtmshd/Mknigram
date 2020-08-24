<template>
  <div>
    <user-show :user="user"></user-show>
    <posts-index :posts-data="user.posts"></posts-index>
  </div>
</template>
<script>
import axios from "axios";

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
    this.setUser().then((result) => {
      this.user = result;
    });
  },
  methods: {
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.$route.params.id}.json`
      );
      return res.data;
    },
  },
};
</script>
<style scoped>
</style>
