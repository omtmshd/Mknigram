<template>
  <div>
    <h4 class="text-h4 text-center">ユーザー一覧</h4>
    <v-row justify="center">
      <v-col cols="12" md="7" lg="7" xl="7">
        <v-expansion-panels accordion>
          <user-index v-for="user in users" :key="user.id" :user="user" :current-user="currentUser"></user-index>
        </v-expansion-panels>
        <infinite-loading @infinite="infiniteUsers" spinner="spiral">
          <div slot="spinner"></div>
          <div slot="no-more"></div>
          <div slot="no-results"></div>
        </infinite-loading>
      </v-col>
    </v-row>
  </div>
</template>
<script>
import axios from "axios";
import { currentUser } from "../../packs/mixins/currentUser";

import UserIndex from "../../components/User/UserIndex.vue";

export default {
  mixins: [currentUser],
  components: { UserIndex },
  data() {
    return {
      users: [],
      infiniteNumber: 0,
    };
  },
  methods: {
    infiniteUsers($state) {
      axios
        .get(`/api/v1/users?data_id=${this.infiniteNumber}`)
        .then(({ data }) => {
          if (9 > data.length) {
            this.users.push(...data);
            $state.complete();
          } else {
            this.infiniteNumber += 9;
            this.users.push(...data);
            $state.loaded();
          }
        });
    },
  },
};
</script>
<style scoped>
</style>
