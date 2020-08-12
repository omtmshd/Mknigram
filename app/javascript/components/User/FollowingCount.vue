<template>
  <div>
    <router-link
      :to="{ name: 'UsersFollowingPage', params: { id: this.$route.params.id } }"
    >フォロー中{{ followingNumber }}</router-link>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      users: {},
    };
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}/following.json`)
      .then((response) => (this.users = response.data));
  },
  computed: {
    followingNumber() {
      return Object.keys(this.users).length;
    },
  },
};
</script>
<style scoped>
</style>
