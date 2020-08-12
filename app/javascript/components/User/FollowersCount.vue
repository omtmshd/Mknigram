<template>
  <div>
    <router-link
      :to="{ name: 'UsersFollowersPage', params: { id: this.$route.params.id } }"
    >フォロワー{{ followersNumber }}</router-link>
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
    this.updateFollewers();
  },
  computed: {
    followersNumber() {
      this.updateFollewers();
      return Object.keys(this.users).length;
    },
  },
  methods: {
    updateFollewers() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}/followers.json`)
        .then((response) => (this.users = response.data));
    },
  },
};
</script>
<style scoped>
</style>
