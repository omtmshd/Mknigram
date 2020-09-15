<template>
  <div>
    <v-dialog v-model="dialog" scrollable :width="dialogWidth">
      <post-show-modal
        :post="post"
        :current-user="currentUser"
        @update-posts="$emit('update-posts')"
      ></post-show-modal>
    </v-dialog>
    <v-col>
      <v-card @click.prevent="showDialog" class="mx-auto" :width="imageWidth" :height="imageHeight">
        <v-img
          :src="post.post_image.url"
          aspect-ratio="1.2"
          gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
        ></v-img>
      </v-card>
    </v-col>
  </div>
</template>
<script>
import LikeButton from "../Like/LikeButton.vue";
import PostShowModal from "./PostShowModal.vue";

export default {
  components: { LikeButton, PostShowModal },
  props: {
    post: {},
    currentUser: {},
  },
  data() {
    return {
      dialog: false,
    };
  },
  computed: {
    imageWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "108";
        case "sm":
          return "216";
        case "md":
          return "336";
        case "lg":
          return "336";
        case "xl":
          return "336";
      }
    },
    imageHeight() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "90";
        case "sm":
          return "180";
        case "md":
          return "280";
        case "lg":
          return "280";
        case "xl":
          return "280";
      }
    },
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "300";
        case "sm":
          return "300";
        case "md":
          return "560";
        case "lg":
          return "560";
        case "xl":
          return "560";
      }
    },
  },
  methods: {
    showDialog() {
      this.dialog = true;
    },
  },
};
</script>

<style scoped>
.col {
  padding: 0.1em;
}
</style>
