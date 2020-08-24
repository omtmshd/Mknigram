<template>
  <user-index :users="users"></user-index>
</template>
<script>
import axios from "axios";

import UserIndex from "../../components/User/UserIndex.vue";

export default {
  components: { UserIndex },
  data() {
    return {
      users: [],
    };
  },
  created() {
    this.setUsers().then((result) => {
      this.users = result;
    });
  },
  methods: {
    setUsers: async function () {
      const res = await axios.get("/api/v1/users.json");
      return res.data;
    },
  },
};
</script>
<style scoped>
</style>
