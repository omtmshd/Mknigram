<template>
  <div>
    <router-view @close="close"></router-view>
    <v-dialog
      v-model="dialog"
      persistent
      scrollable
      max-width="560"
      @click:outside="close"
      style="margin: 0px;"
    >
      <post-show :post="post" :current-user="currentUser"></post-show>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import { currentUser } from "../../packs/mixins/currentUser";

import PostShow from "./PostShow.vue";

export default {
  mixins: [currentUser],
  components: { PostShow },
  data() {
    return {
      dialog: true,
      post: {
        id: "",
        title: "",
        body: "",
        post_image: {
          url: "",
        },
        user_id: "",
      },
    };
  },
  mounted() {
    this.setPost();
  },
  watch: { $route: "setPost" },
  methods: {
    setPost() {
      axios
        .get(`/api/v1/posts/${this.$route.params.post_id}`)
        .then((response) => (this.post = response.data));
    },
    close() {
      const arr = this.$route.path.split("/");
      arr.pop();
      if (arr.length > 1) {
        this.$router.push({
          path: arr.join("/"),
        });
      } else {
        this.$router.push({
          path: "/",
        });
      }
    },
  },
};
</script>

<style>
.v-dialog {
  margin: 0px;
}
</style>
