<template>
  <div>
    <v-avatar size="36" @click.stop="showUser" class="avatar_padding">
      <img v-if="user.profile_image.url !== null" :src="user.profile_image.url" />
      <v-icon v-else size="36" color="#90A4AE" dark>mdi-account-circle</v-icon>
    </v-avatar>
    <span class="text-xs-caption">{{user.name}}</span>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: ["userId"],
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
        name: "",
      },
    };
  },
  watch: {
    userId: "setUser",
  },
  mounted() {
    this.setUser();
  },
  methods: {
    setUser() {
      if (this.userId > 0) {
        axios.get(`/api/v1/users/${this.userId}`).then(({ data }) => {
          this.user = data;
        });
      }
    },
    showUser() {
      if (this.$route.path !== `/users/${this.user.id}/posts`) {
        this.$router.push(`/users/${this.user.id}/posts`);
      }
    },
  },
};
</script>
<style scoped>
.avatar_padding {
  margin: 0.1em 0;
}
</style>
