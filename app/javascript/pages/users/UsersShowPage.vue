<template>
  <div>
    <v-dialog v-model="dialogFollowing" scrollable :width="dialogWidth">
      <user-following-modal :current-user="currentUser"></user-following-modal>
    </v-dialog>
    <v-dialog v-model="dialogFollowers" scrollable :width="dialogWidth">
      <user-followers-modal :current-user="currentUser"></user-followers-modal>
    </v-dialog>

    <user-show
      :user="user"
      :current-user="currentUser"
      @user-reset="setUser"
      @show-following="dialogFollowing = true"
      @show-followers="dialogFollowers = true"
    ></user-show>
    <v-container class="mx-auto">
      <v-card :max-width="cardWidth" class="mx-auto" color="rgba(255, 255, 255, .4)" flat>
        <v-container class="mx-auto">
          <v-row align="center" justify="end">
            <v-btn-toggle v-model="tabs" tile group color="#37474F">
              <v-btn value="tab-1" @click="postsShow">投稿</v-btn>

              <v-btn value="tab-2" @click="likePostsShow">いいね</v-btn>
            </v-btn-toggle>
          </v-row>
        </v-container>

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

      tabs: "tab-1",
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
        this.dialogFollowing = this.dialogFollowers = false;
        if (this.$route.path === `/users/${this.user.id}/`) {
          this.tabs = "tab-1";
        }
        if (this.$route.path === `/users/${this.user.id}/like`) {
          this.tabs = "tab-2";
        }
      });
    },
    postsShow() {
      if (this.$route.path !== `/users/${this.user.id}/`) {
        this.$router.push({
          name: "UserPostsPage",
          params: { id: this.user.id },
        });
      }
    },
    likePostsShow() {
      if (this.$route.path !== `/users/${this.user.id}/like`) {
        this.$router.push({
          name: "LikePostsPage",
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
.theme--light.v-tabs-items {
  background-color: rgba(255, 255, 255, 0.4);
}
</style>
