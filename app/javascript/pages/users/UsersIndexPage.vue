<template>
  <user-index :users="users" :page-label="pageLabel"></user-index>
</template>
<script>
import axios from "axios";

import UserIndex from "../../components/User/UserIndex.vue";

export default {
  components: { UserIndex },
  data() {
    return {
      users: [],
      pageLabel: "ユーザー一覧",
    };
  },
  mounted() {
    this.setUsers().then((result) => {
      this.users = result;
    });
  },
  methods: {
    async setUsers() {
      const res = await axios.get("/api/v1/users.json");
      return res.data;
    },
  },
};
</script>
<style scoped>
</style>
