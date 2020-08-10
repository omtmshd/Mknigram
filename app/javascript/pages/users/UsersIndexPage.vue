<template>
  <div>
    <div v-for="u in users" :key="u.id">
      <p>{{ u.id }}</p>
      <p>{{ u.name }}</p>
      <p>{{ u.profile }}</p>
      <div v-if="u.profile_image">{{ u.profile_image }}</div>
      <div v-else>
        <img src="/assets/default.png" />
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data: function () {
    return {
      users: [],
    };
  },
  mounted() {
    axios
      .get("/api/v1/users.json")
      .then((response) => (this.users = response.data));
  },
};
</script>
<style scoped>
</style>
