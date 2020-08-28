<template>
  <div>
    <user-show :user="user" @set-follow="updateUser()"></user-show>
    <div v-if="user.followers.length !== 0">
      <user-index :users="user.followers" :page-label="pageLabel" @set-follow="updateUser()"></user-index>
    </div>
    <div v-else>
      <v-container>
        <div class="text-subtitle-1 text-center">フォロワーがいません</div>
      </v-container>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import { csrfToken } from "rails-ujs";
axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken();

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
      pageLabel: "フォロワー",
    };
  },
  created() {
    this.updateUser();
  },
  watch: { $route: "updateUser" },
  methods: {
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.$route.params.id}/following.json`
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
