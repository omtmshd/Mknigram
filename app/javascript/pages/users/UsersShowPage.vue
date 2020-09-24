<template>
  <div>
    <v-dialog v-model="dialogFollowing" scrollable :width="dialogWidth">
      <user-following-modal :current-user="currentUser"></user-following-modal>
    </v-dialog>
    <v-dialog v-model="dialogFollowers" scrollable :width="dialogWidth">
      <user-followers-modal :current-user="currentUser"></user-followers-modal>
    </v-dialog>
    <v-container>
      <v-card flat class="mx-auto" color="rgba(255,255,255,.85)">
        <user-show
          :user="user"
          :current-user="currentUser"
          @user-reset="setUser"
          @show-following="dialogFollowing = true"
          @show-followers="dialogFollowers = true"
        ></user-show>
        <v-tabs v-model="tabs" color="#37474F">
          <v-tab href="#tab-1" @click="postsShow">投稿</v-tab>
          <v-tab href="#tab-2" @click="likePostsShow">いいね</v-tab>
          <v-tab href="#tab-3" @click="ListsIndexShow">リスト</v-tab>
        </v-tabs>
        <router-view></router-view>
      </v-card>
    </v-container>
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
    $route: "setUser",
  },
  methods: {
    setUser() {
      axios.get(`/api/v1/users/${this.$route.params.id}`).then(({ data }) => {
        this.user = data;
        switch (this.$route.path) {
          case `/users/${this.user.id}/posts`:
            this.tabs = "tab-1";
            break;
          case `/users/${this.user.id}/likes`:
            this.tabs = "tab-2";
            break;
          case `/users/${this.user.id}/list_folders`:
            this.tabs = "tab-3";
            break;
          default:
            this.tabs = "";
            break;
        }
      });
    },
    postsShow() {
      if (this.$route.path !== `/users/${this.user.id}/posts`) {
        this.$router.push({
          name: "UserPostsPage",
          params: { id: this.user.id },
        });
      }
    },
    likePostsShow() {
      if (this.$route.path !== `/users/${this.user.id}/likes`) {
        this.$router.push({
          name: "LikePostsPage",
          params: { id: this.user.id },
        });
      }
    },
    ListsIndexShow() {
      if (this.$route.path !== `/users/${this.user.id}/list_folders`) {
        this.$router.push({
          name: "ListFolderIndex",
          params: { id: this.user.id },
        });
      }
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
    tabsWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "330";
        case "sm":
          return "400";
        case "md":
          return "400";
        case "lg":
          return "400";
        case "xl":
          return "400";
      }
    },
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "360";
        case "sm":
          return "665";
        case "md":
          return "1330";
        case "lg":
          return "1330";
        case "xl":
          return "1330";
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
