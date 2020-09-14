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
    <v-card color="rgba(255,255,255,0)" flat :max-width="cardWidth" class="mx-auto">
      <v-tabs
        v-model="tabsKey"
        centered
        color="#263238"
        background-color="rgba(255,255,255,0)"
        @change="likePostsReset"
      >
        <v-tab href="#tab-1">投稿</v-tab>
        <v-tab href="#tab-2">いいね</v-tab>
      </v-tabs>

      <v-tabs-items v-model="tabsKey">
        <v-tab-item value="tab-1" eager>
          <user-posts :current-user="currentUser"></user-posts>
        </v-tab-item>

        <v-tab-item value="tab-2" eager>
          <like-posts :current-user="currentUser" ref="posts_reset"></like-posts>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";
import { currentUser } from "../../packs/mixins/currentUser";

import UserShow from "../../components/User/UserShow.vue";
import UserFollowingModal from "../../components/follow/UserFollowingModal.vue";
import UserFollowersModal from "../../components/follow/UserFollowersModal.vue";
import UserPosts from "../../components/Post/UserPosts.vue";
import LikePosts from "../../components/Post/LikePosts.vue";

export default {
  mixins: [currentUser],
  components: {
    UserShow,
    UserFollowingModal,
    UserFollowersModal,
    UserPosts,
    LikePosts,
  },
  data() {
    return {
      user: {
        profile_image: {
          url: "",
        },
      },

      tabsKey: "tab-1",

      dialogFollowing: false,
      dialogFollowers: false,
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
      });
      this.dialogFollowing = this.dialogFollowers = false;
      this.tabsKey = "tab-1";
    },
    likePostsReset() {
      this.$refs.posts_reset.$emit("updatePosts");
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
