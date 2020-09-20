<template>
  <v-container>
    <v-card class="mx-auto" width="350">
      <v-container>
        <v-row justify="center" align="center">
          <v-col cols="4">
            <v-avatar size="62">
              <img v-if="user.profile_image.url !== null" :src="user.profile_image.url" />
              <v-icon v-else size="62" color="#90A4AE" dark>mdi-account-circle</v-icon>
            </v-avatar>
          </v-col>
          <v-col cols="7">
            <strong>{{ user.name}}</strong>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <v-card-subtitle>{{user.email}}</v-card-subtitle>
        <v-card-text v-if="user.profile">{{ user.profile }}</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn icon @click.stop="deleteDialog = true">
            <v-icon color="#E53935">mdi-account-remove</v-icon>
          </v-btn>
          <v-dialog v-model="deleteDialog" width="350">
            <v-card>
              <v-card-title>本当にこのユーザーを削除しますか？</v-card-title>
              <v-card-actions>
                <v-btn text @click.stop="deleteDialog = false">キャンセル</v-btn>
                <v-spacer></v-spacer>
                <v-btn text color="#E53935" @click.stop="deleteUser">削除</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-card-actions>
      </v-container>
    </v-card>
  </v-container>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
      },
      deleteDialog: false,
    };
  },

  created() {
    this.setUser();
  },
  watch: {
    $route: "setUser",
  },
  methods: {
    setUser() {
      axios
        .get(`/api/v1/admin/users/${this.$route.params.id}`, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then(({ data }) => {
          this.user = data;
        });
    },
    deleteUser() {
      axios
        .delete(`/api/v1/admin/users/${this.$route.params.id}`, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then(this.$router.push({ path: "/" }));
    },
  },
  computed: {
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "335";
        case "sm":
          return "665";
        case "md":
          return "1030";
        case "lg":
          return "1030";
        case "xl":
          return "1030";
      }
    },
  },
};
</script>
<style scoped>
</style>
