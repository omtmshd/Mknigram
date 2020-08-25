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
      <div v-for="user in displayUsers" :key="user.id">
        <v-col>
          <v-card class="mx-auto" max-width="350" min-width="350" @click="showUser(user.id)">
            <v-container>
              <v-card-actions>
                <v-avatar size="62">
                  <img v-if="user.profile_image.url != null" :src="user.profile_image.url" />
                  <v-icon v-else size="62" color="#FFEE58" dark>mdi-account-circle</v-icon>
                </v-avatar>
                <v-spacer></v-spacer>
                <user-follow-form :user-id="user.id"></user-follow-form>
              </v-card-actions>
              <v-card-title>{{ user.name}}</v-card-title>
              <v-card-text>{{ user.profile }}</v-card-text>
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
import UserFollowForm from "./UserFollowForm.vue";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  components: { UserFollowForm },
  mixins: [currentUser],
  props: {
    users: {
      type: Array,
      default: [],
    },
  },
  data: function () {
    return {
      page: 1, //現在のページ
      pageSize: 12, //1ページに入るuserの数
      length: 0, //ページ数
    };
  },
  computed: {
    displayUsers() {
      this.length = Math.ceil(this.users.length / this.pageSize);
      return this.users.slice(
        this.pageSize * (this.page - 1),
        this.pageSize * this.page
      );
    },
  },
  methods: {
    showUser(i) {
      this.$router.push({
        name: "UsersShowPage",
        params: { id: i },
      });
    },
  },
};
</script>
<style scoped>
.v-card {
  margin: 1em;
}
</style>
