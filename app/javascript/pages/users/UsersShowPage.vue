<template>
  <div>
    <p>{{ user.id }}</p>
    <p>{{ user.name}}</p>
    <p>{{ user.profile}}</p>
    <div v-if="user.profile_image">{{ user.profile_image }}</div>
    <div v-else>
      <img src="/assets/default.png" />
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      user: {},
    };
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then((response) => (this.user = response.data));
  },
};
</script>
<style scoped>
</style>
