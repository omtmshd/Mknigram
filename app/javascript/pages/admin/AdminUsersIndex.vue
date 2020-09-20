<template>
  <div>
    <div v-for="user in users" :key="user.id">
      <v-card
        width="500"
        color="rgba(255,255,255,0.8)"
        class="mx-auto"
        @click.stop="showUser(user.id)"
      >
        <v-list-item class="px-1">
          <v-list-item-avatar class="link" size="56">
            <img v-if="user.profile_image.url != null" :src="user.profile_image.url" />
            <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
          </v-list-item-avatar>
          <v-list-item-title class="px-1">
            <v-list>
              <v-list-item class="px-1">
                <v-list-item-title>{{user.name}}</v-list-item-title>
                <v-list-item-action-text></v-list-item-action-text>
              </v-list-item>
              <v-list-item class="px-1">
                <v-list-item-subtitle class="py-1">{{user.profile}}</v-list-item-subtitle>
              </v-list-item>
            </v-list>
          </v-list-item-title>
        </v-list-item>
      </v-card>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import AdminUsersShowVue from "./AdminUsersShow.vue";

export default {
  data() {
    return {
      users: [],
    };
  },
  created() {
    axios
      .get("/api/v1/admin/users", {
        headers: {
          "access-token": localStorage.getItem("access-token"),
          uid: localStorage.getItem("uid"),
          client: localStorage.getItem("client"),
        },
      })
      .then(({ data }) => {
        this.users = data;
      });
  },
  methods: {
    showUser(i) {
      this.$router.push(`/users/${i}/`);
    },
  },
};
</script>
