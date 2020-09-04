<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      <v-row align="center" no-gutters>
        <v-col cols="3" md="2" lg="2" xl="2">
          <v-avatar class="link" size="56" @click.stop="showUser">
            <img v-if="user.profile_image.url != null" :src="user.profile_image.url" />
            <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
          </v-avatar>
        </v-col>
        <v-col cols="7" md="3" lg="3" xl="3">
          <strong v-text="user.name"></strong>
        </v-col>
        <v-col cols="12" md="7" lg="7" xl="7">
          <user-follow-form
            :user-id="user.id"
            :current-user="currentUser"
            @show-following="showUser"
            @show-followers="showUser"
            @user-reset="$emit('user-reset')"
          ></user-follow-form>
        </v-col>
      </v-row>
    </v-expansion-panel-header>

    <v-expansion-panel-content>
      <v-divider></v-divider>
      <v-card-text v-text="user.profile"></v-card-text>
    </v-expansion-panel-content>
  </v-expansion-panel>
</template>
<script>
import UserFollowForm from "./UserFollowForm.vue";

export default {
  components: { UserFollowForm },
  props: {
    user: {},
    currentUser: {},
  },
  data() {
    return {};
  },
  computed: {},
  methods: {
    showUser() {
      this.$router.push({
        name: "UsersShowPage",
        params: { id: this.user.id },
      });
    },
  },
};
</script>
<style scoped>
.v-card {
  margin: 1em;
}
</style>
