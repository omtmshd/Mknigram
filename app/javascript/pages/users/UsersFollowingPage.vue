<template>
  <v-card>
    <user-show :user="user" @set-follow="updateUser()"></user-show>
    <div v-if="user.following.length !== 0">
      <user-index :users="user.following" :page-label="pageLabel" @set-follow="updateUser()"></user-index>
    </div>
    <div v-else>
      <v-container>
        <div class="text-subtitle-1 text-center">フォロー中のユーザーがいません</div>
      </v-container>
    </div>
  </v-card>
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
      pageLabel: "フォロー中",
    };
  },
  mounted() {
    this.updateUser();
  },
  watch: { $route: "updateUser" },
  methods: {
    async setUser() {
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
