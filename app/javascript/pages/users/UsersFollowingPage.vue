<template>
  <div>
    <user-show :user="user"></user-show>
    <div class="text-h6 text-center text-decoration-underline">フォロー中</div>
    <div v-if="user.following.length !== 0">
      <user-index :users="user.following"></user-index>
    </div>
    <div v-else>
      <v-container>
        <div class="text-subtitle-1 text-center">フォロー中のユーザーがいません</div>
      </v-container>
    </div>
  </div>
</template>
<script>
import axios from "axios";

import UserShow from "../../components/User/UserShow.vue";
import UserIndex from "../../components/User/UserIndex.vue";

export default {
  components: {
    UserShow,
    UserIndex,
  },
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
        posts: [],
        following: [],
        followers: [],
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
        `/api/v1/users/${this.$route.params.id}/following.json`
      );
      return res.data;
    },
  },
};
</script>
<style scoped>
</style>
