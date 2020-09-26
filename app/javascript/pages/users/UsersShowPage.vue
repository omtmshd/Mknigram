<template>
  <div>
    <v-dialog v-model="dialogFollowing" scrollable :width="dialogWidth">
      <user-following-modal :current-user="currentUser"></user-following-modal>
    </v-dialog>
    <v-dialog v-model="dialogFollowers" scrollable :width="dialogWidth">
      <user-followers-modal :current-user="currentUser"></user-followers-modal>
    </v-dialog>

    <v-card flat class="mx-auto" color="rgba(255,255,255,0)" :width="cardWidth" min-height="100vh">
      <user-show
        :user="user"
        :current-user="currentUser"
        @user-reset="setUser"
        @show-following="dialogFollowing = true"
        @show-followers="dialogFollowers = true"
      ></user-show>
      <v-tabs v-model="tabs" color="#37474F" background-color="rgba(255,255,255,0)">
        <v-tab href="#tab-1" @click.stop="showPosts">投稿</v-tab>
        <v-tab href="#tab-2" @click.stop="showLikes">いいね</v-tab>
        <v-tab href="#tab-3" @click.stop="showLists">リスト</v-tab>
      </v-tabs>
      <router-view></router-view>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";
import { currentUser } from "../../packs/mixins/currentUser";

import UserShow from "../../components/User/UserShow.vue";
import UserFollowingModal from "../../components/follow/UserFollowingModal.vue";
import UserFollowersModal from "../../components/follow/UserFollowersModal.vue";

export default {
  mixins: [currentUser],
  components: {
    UserShow,
    UserFollowingModal,
    UserFollowersModal,
  },
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
      },

      dialogFollowing: false,
      dialogFollowers: false,

      tabs: "",
    };
  },

  mounted() {
    this.setUser();
  },
  watch: {
    tabs: "setUser",
    watchId: "setUser",
  },
  methods: {
    setUser() {
      axios.get(`/api/v1/users/${this.$route.params.id}`).then(({ data }) => {
        this.user = data;
      });
      this.setTabs();
    },
    setTabs() {
      switch (this.$route.path) {
        case `/users/${this.$route.params.id}/posts`:
          this.tabs = "tab-1";
          break;
        case `/users/${this.$route.params.id}/likes`:
          this.tabs = "tab-2";
          break;
        case `/users/${this.$route.params.id}/list_folders`:
          this.tabs = "tab-3";
          break;
      }
    },
    showPosts() {
      if (this.$route.path !== `/users/${this.$route.params.id}/posts`) {
        this.$router.push(`/users/${this.$route.params.id}/posts`);
      }
    },
    showLikes() {
      if (this.$route.path !== `/users/${this.$route.params.id}/likes`) {
        this.$router.push(`/users/${this.$route.params.id}/likes`);
      }
    },
    showLists() {
      if (this.$route.path !== `/users/${this.$route.params.id}/list_folders`) {
        this.$router.push(`/users/${this.$route.params.id}/list_folders`);
      }
    },
  },
  computed: {
    watchId() {
      return this.$route.params.id;
    },
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "330";
        case "sm":
          return "400";
        default:
          return "600";
      }
    },
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "320";
        case "sm":
          return "950";
        default:
          return "1230";
      }
    },
  },
};
</script>
<style scoped>
.theme--light.v-tabs-items {
  background-color: rgba(255, 255, 255, 0.4);
}
</style>
