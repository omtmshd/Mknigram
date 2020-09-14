<template>
  <v-card width="500" color="rgba(255,255,255,0.8)" class="mx-auto">
    <v-list-item class="px-1">
      <v-list-item-avatar class="link" size="56" @click.stop="showUser">
        <img v-if="user.profile_image.url != null" :src="user.profile_image.url" />
        <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
      </v-list-item-avatar>
      <v-list-item-title class="px-1">
        <v-list>
          <v-list-item class="px-1">
            <v-list-item-title>{{user.name}}</v-list-item-title>
            <v-list-item-action-text>
              <user-follow-form
                :user-page="userPage"
                :user-id="user.id"
                :current-user="currentUser"
                @show-following="showUser"
                @show-followers="showUser"
                @user-reset="$emit('user-reset')"
              ></user-follow-form>
            </v-list-item-action-text>
          </v-list-item>
          <v-list-item class="px-1">
            <v-list-item-subtitle class="py-1">{{user.profile}}</v-list-item-subtitle>
          </v-list-item>
        </v-list>
      </v-list-item-title>
    </v-list-item>
  </v-card>
</template>
<script>
import UserFollowForm from "../follow/UserFollowForm.vue";

export default {
  components: { UserFollowForm },
  props: {
    user: {},
    currentUser: {},
    userPage: {
      type: Boolean,
      default: false,
    },
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
  filters: {
    truncate(value) {
      var length = 40;
      var ommision = "...";
      if (value.length <= length) {
        return value;
      }
      return value.substring(0, length) + ommision;
    },
  },
};
</script>
<style scoped>
.v-card {
  margin: 0;
}
.theme--light.v-list {
  background-color: rgba(255, 255, 255, 0);
}
</style>
