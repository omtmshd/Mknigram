<template>
  <v-hover v-slot:default="{ hover }">
    <v-card
      @click.prevent="showDialog"
      :width="imageWidth"
      flat
      tile
      hover
      :elevation="hover ? 9 : 0"
      :class="marginY"
    >
      <v-img
        :src="post.post_image.url"
        gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
        :width="imageWidth"
      ></v-img>
    </v-card>
  </v-hover>
</template>
<script>
import PostShow from "./PostShow.vue";

export default {
  components: { PostShow },
  props: {
    post: {},
    currentUser: {},
  },
  computed: {
    imageWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "107";
        case "sm":
          return "250";
        default:
          return "390";
      }
    },
    marginY() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "my-2";
        case "sm":
          return "my-3";
        default:
          return "my-6";
      }
    },
  },
  methods: {
    showDialog() {
      if (this.$route.path === "/") {
        this.$router.push({
          path: `/${this.post.id}`,
        });
      } else {
        this.$router.push({
          path: `${this.$route.path}/${this.post.id}`,
        });
      }
    },
  },
};
</script>

<style scoped>
</style>
