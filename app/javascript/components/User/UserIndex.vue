<template>
  <v-container>
    <h4 class="text-h4 text-center">{{pageLabel}}</h4>
    <v-row justify="center">
      <v-col cols="12" md="7" lg="7" xl="7">
        <v-expansion-panels accordion>
          <v-expansion-panel v-for="user in displayUsers" :key="user.id">
            <v-expansion-panel-header>
              <v-row align="center" no-gutters>
                <v-col cols="3" md="2" lg="2" xl="2">
                  <v-avatar class="link" size="56" @click.stop="showUser(user.id)">
                    <img v-if="user.profile_image.url != null" :src="user.profile_image.url" />
                    <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
                  </v-avatar>
                </v-col>
                <v-col cols="7" md="3" lg="3" xl="3">
                  <strong v-text="user.name"></strong>
                </v-col>
                <v-col cols="12" md="7" lg="7" xl="7">
                  <user-follow-form :user-id="user.id" @set-follow="setFollow()"></user-follow-form>
                </v-col>
              </v-row>
            </v-expansion-panel-header>

            <v-expansion-panel-content>
              <v-divider></v-divider>
              <v-card-text v-text="user.profile"></v-card-text>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-col>
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
  </v-container>
</template>
<script>
import UserFollowForm from "./UserFollowForm.vue";

export default {
  components: { UserFollowForm },
  props: {
    users: {
      type: Array,
      default: [],
    },
    pageLabel: "",
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
    setFollow() {
      this.$emit("set-follow");
    },
  },
};
</script>
<style scoped>
.v-card {
  margin: 1em;
}
</style>
