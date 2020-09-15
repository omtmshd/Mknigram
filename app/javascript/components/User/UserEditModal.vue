<template>
  <v-card width="350" class="mx-auto" height="330">
    <v-container>
      <v-form @submit.prevent="updateUser">
        <div v-if="errors.length !== 0">
          <ul v-for="e in errors" :key="e">
            <li>
              <font color="red">{{ e }}</font>
            </li>
          </ul>
        </div>
        <v-row justify="center" align="end">
          <v-col cols="4">
            <v-avatar size="100">
              <img v-if="image !== 'not'" :src="image" />
              <v-icon v-else size="100" color="#90A4AE" dark>mdi-account-circle</v-icon>
            </v-avatar>
          </v-col>
          <v-col cols="2">
            <v-file-input
              @change="selectedFile"
              prepend-icon="mdi-camera"
              hide-input
              :clearable="false"
              width="350"
            ></v-file-input>
          </v-col>
        </v-row>
        <v-textarea
          counter="150"
          rows="4"
          v-model="user.profile"
          label="プロフィール"
          width="350"
          required
        ></v-textarea>
        <p>
          <v-btn text class="mr-4" @click="editCancel">キャンセル</v-btn>
          <v-btn text right class="mr-4" absolute type="submit">保存</v-btn>
        </p>
      </v-form>
    </v-container>
  </v-card>
</template>
<script>
import axios from "axios";

export default {
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
  mounted() {
    this.setUser().then((result) => {
      this.user = result;
      if (this.user.profile_image.url !== null) {
        this.image = this.user.profile_image.url;
      }
    });
  },
  methods: {
    async setUser() {
      const res = await axios.get(`/api/v1/users/${this.$route.params.id}`);
      return res.data;
    },
    selectedFile(e) {
      if (!e) {
        this.user.profile_image = null;
        this.image = "not";
      } else {
        this.user.profile_image = e;
        this.image = window.URL.createObjectURL(e);
      }
    },
    editCancel() {
      this.setUser();
      this.$emit("close");
    },
    async updateUser() {
      let formData = new FormData();
      formData.append("user[profile]", this.user.profile);
      formData.append("user[profile_image]", this.user.profile_image);
      const res = await axios
        .patch(`/api/v1/users/${this.user.id}`, formData, {
          headers: {
            "content-type": "multipart/form-data",
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((response) => {
          this.$emit("close");
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
