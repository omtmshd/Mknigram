<template>
  <v-container>
    <div class="text-center">
      <v-pagination
        color="#43A047"
        v-model="page"
        :length="length"
        :total-visible="5"
        prev-icon="mdi-menu-left"
        next-icon="mdi-menu-right"
      ></v-pagination>
    </div>
    <v-row justify="center">
      <div v-for="p in displayPosts" :key="p.index">
        <post-show :post="p" v-show="showPost === p.id" @from-child="closeModal"></post-show>
        <v-col>
          <v-card class="mx-auto" max-width="300" min-width="300">
            <v-container @click.prevent="openModal(p.id)">
              <v-img :src="p.post_image.url" aspect-ratio="1.7" contain></v-img>
              <v-card-title>{{ p.title }}</v-card-title>
              <v-breadcrumbs :items="p.categories" text="name">
                <template v-slot:item="{ item }">
                  <v-breadcrumbs-item>{{ item.name }}</v-breadcrumbs-item>
                </template>
              </v-breadcrumbs>
              <v-divider class="mx-4"></v-divider>
              <v-card-actions>
                <v-avatar size="62" @click.stop="showUser(p.user.id)">
                  <img v-if="p.user.profile_image.url != null" :src="p.user.profile_image.url" />
                  <v-icon v-else size="62" color="#FFEE58" dark>mdi-account-circle</v-icon>
                </v-avatar>
                <v-spacer></v-spacer>
                <like-button :post-id="p.id" :user-id="currentUser.id"></like-button>
              </v-card-actions>
            </v-container>
          </v-card>
        </v-col>
      </div>
    </v-row>
    <div class="text-center">
      <v-pagination
        color="#43A047"
        v-model="page"
        :length="length"
        :total-visible="5"
        prev-icon="mdi-menu-left"
        next-icon="mdi-menu-right"
      ></v-pagination>
    </div>
  </v-container>
</template>
<script>
import LikeButton from "../Like/LikeButton.vue";
import PostShow from "./PostShow.vue";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  components: { LikeButton, PostShow },
  props: {
    postsData: {
      type: Array,
      default: [],
    },
  },
  data() {
    return {
      page: 1, //現在のページ
      pageSize: 12, //1ページに入るpostの数
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
  },
};
</script>

<style>
.v-card {
  margin: 1em;
}
#content {
  z-index: 10;
}
#overlay {
  /*　要素を重ねた時の順番　*/

  z-index: 1;

  /*　画面全体を覆う設定　*/
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
