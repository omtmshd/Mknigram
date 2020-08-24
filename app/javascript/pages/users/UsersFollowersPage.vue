<template>
  <div>
    <user-show :user="user" :followData="user.followers.length" @set="setFollowers()"></user-show>
    <div class="text-h6 text-center text-decoration-underline">フォロワー</div>
    <div v-if="user.followers.length !== 0">
      <user-index :users="user.followers"></user-index>
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
    this.setFollowers();
  },
  methods: {
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.$route.params.id}/following.json`
      );
      return res.data;
    },
    setFollowers() {
      this.setUser().then((result) => {
        this.user = result;
      });
    },
  },
};
</script>
<style scoped>
</style>
