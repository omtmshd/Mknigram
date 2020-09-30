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
              <img v-if="image !== null" :src="image" />
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
          color="black"
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
  props: {
    user: {
      profile_image: {
        url: "",
      },
    },
  },
  data() {
    return {
      errors: "",
      image: false,
      fileChange: false,
    };
  },
  mounted() {
    this.setUser();
  },
  methods: {
    setUser() {
      this.image = this.user.profile_image.url;
      this.fileChange = false;
    },
    selectedFile(e) {
      if (!e) {
        this.user.profile_image.url = null;
        this.image = null;
        this.fileChange = false;
      } else {
        this.user.profile_image = e;
        this.image = window.URL.createObjectURL(e);
        this.fileChange = true;
      }
    },
    editCancel() {
      this.setUser();
      this.$emit("close");
    },
    updateUser() {
      let formData = new FormData();
      if (this.user.profile) {
        formData.append("user[profile]", this.user.profile);
      }

      if (this.fileChange) {
        formData.append("user[profile_image]", this.user.profile_image);
      }

      axios
        .patch(`/api/v1/users/${this.$route.params.id}`, formData, {
          headers: {
            "content-type": "multipart/form-data",
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((response) => {
          this.setUser();
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
