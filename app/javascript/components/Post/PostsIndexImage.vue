<template>
  <div>
    <v-row justify="center">
      <div v-for="p in displayPosts" :key="p.index">
        <post-show-modal
          :post="p"
          v-show="showPost === p.id"
          @from-child="closeModal"
          @update-posts="updatePosts()"
        ></post-show-modal>
        <v-col>
          <v-card
            @click.prevent="openModal(p.id)"
            class="mx-auto"
            :width="imageWidth"
            :height="imageHight"
          >
            <v-img
              :src="p.post_image.url"
              aspect-ratio="1.2"
              gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
            ></v-img>
          </v-card>
        </v-col>
      </div>
    </v-row>
    <div class="text-center">
      <v-pagination
        color="#FDD835"
        v-model="page"
        :length="length"
        :total-visible="5"
        prev-icon="mdi-menu-left"
        next-icon="mdi-menu-right"
      ></v-pagination>
    </div>
  </div>
</template>
<script>
import LikeButton from "../Like/LikeButton.vue";
import PostShowModal from "./PostShowModal.vue";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  components: { LikeButton, PostShowModal },
  props: {
    postsData: {
      type: Array,
      default: [],
    },
  },
  data() {
    return {
      page: 1, //現在のページ
      pageSize: 30, //1ページに入るpostの数
      length: 0, //ページ数
      showPost: -1,
    };
  },
  computed: {
    displayPosts() {
      this.length = Math.ceil(this.postsData.length / this.pageSize);
      return this.postsData.slice(
        this.pageSize * (this.page - 1),
        this.pageSize * this.page
      );
    },
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
    imageHight() {
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
  },
  methods: {
    openModal(i) {
      this.showPost = i;
    },
    closeModal() {
      this.showPost = -1;
    },
    showUser(i) {
      this.$router.push({
        name: "UsersShowPage",
        params: { id: i },
      });
    },
    updatePosts() {
      this.$emit("update-posts");
    },
  },
};
</script>

<style scoped>
.col {
  padding: 0.1em;
}
</style>
