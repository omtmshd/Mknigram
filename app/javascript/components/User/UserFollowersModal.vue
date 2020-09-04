<template>
  <v-card :width="dialogWidth">
    <v-card-title>フォロワー</v-card-title>
    <v-divider></v-divider>
    <v-card-text :style="dialogHeight">
      <v-expansion-panels accordion>
        <user-index
          v-for="followerUser in userFollowers"
          :key="followerUser.index"
          :user="followerUser"
          :current-user="currentUser"
          @user-reset="getFollowers"
        ></user-index>
      </v-expansion-panels>
    </v-card-text>
  </v-card>
</template>
<script>
import axios from "axios";

import UserIndex from "./UserIndex.vue";

export default {
  components: {
    UserIndex,
  },
  props: {
    currentUser: {},
  },
  data() {
    return {
      userFollowers: [],
    };
  },
  mounted() {
    this.getFollowers();
  },
  watch: { $route: "getFollowers" },
  methods: {
    getFollowers() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}/followers`)
        .then(({ data }) => {
          this.userFollowers = data;
        });
    },
  },
  computed: {
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "330";
        case "sm":
          return "400";
        case "md":
          return "600";
        case "lg":
          return "600";
        case "xl":
          return "600";
      }
    },
    dialogHeight() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "max-height: 500px;";
        case "sm":
          return "max-height: 600px;";
        case "md":
          return "max-height: 600px;";
        case "lg":
          return "max-height: 600px;";
        case "xl":
          return "max-height: 600px;";
      }
    },
  },
};
</script>
<style scoped>
.v-dialog > .v-card > .v-card__text {
  padding: 0;
}
</style>
