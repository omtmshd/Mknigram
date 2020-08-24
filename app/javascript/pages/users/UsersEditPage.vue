<template>
  <v-container>
    <v-card class="mx-auto">
      <v-container>
        <v-form @submit.prevent="updateUser">
          <div v-if="errors.length !== 0">
            <ul v-for="e in errors" :key="e">
              <li>
                <font color="red">{{ e }}</font>
              </li>
            </ul>
          </div>
          <v-avatar size="62">
            <img v-if="image !== 'not'" :src="image" />
            <v-icon v-else size="62" color="yellow lighten-1" dark>mdi-account-circle</v-icon>
          </v-avatar>
          <v-file-input label="プロフィール画像" @change="selectedFile"></v-file-input>
          <v-textarea v-model="user.profile" label="プロフィール" required></v-textarea>
          <v-btn class="mr-4" type="submit">更新</v-btn>
        </v-form>
      </v-container>
    </v-card>
  </v-container>
</template>
<script>
import axios from "axios";
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  data() {
    return {
      errors: "",
      user: {
        name: "",
        profile: "",
        profile_image: "",
      },
      image: "not",
    };
  },
  created() {
    this.setUser().then((result) => {
      this.user = result;
      if (this.user.profile_image.url !== null) {
        this.image = this.user.profile_image.url;
      }
    });
  },
  methods: {
    setUser: async function () {
      const res = await axios.get(
        `/api/v1/users/${this.$route.params.id}.json`
      );
      return res.data;
    },
    selectedFile(e) {
      this.user.profile_image = e;
      this.image = window.URL.createObjectURL(e);
    },
    updateUser: async function () {
      let formData = new FormData();
      formData.append("user[profile]", this.user.profile);
      formData.append("user[profile_image]", this.user.profile_image);
      const res = await axios
        .patch(`/api/v1/users/${this.user.id}`, formData, {
          headers: {
            "content-type": "multipart/form-data",
          },
        })
        .then((response) => {
          this.$router.push({
            name: "UsersShowPage",
            params: { id: this.user.id },
          });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  },
};
</script>
<style scoped>
</style>
