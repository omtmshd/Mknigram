<template>
  <v-container>
    <v-card class="mx-auto" max-width="400">
      <v-container>
        <v-form @submit.prevent="updateUser">
          <v-row justify="center">
            <v-col cols="10">
              <div v-if="errors.length !== 0">
                <ul v-for="e in errors" :key="e">
                  <li>
                    <font color="red">{{ e }}</font>
                  </li>
                </ul>
              </div>
              <v-row justify="center">
                <v-col cols="12">
                  <v-expansion-panels accordion>
                    <v-expansion-panel>
                      <v-expansion-panel-header>
                        <v-row align="center" no-gutters>
                          <v-col cols="5">
                            <v-avatar size="56">
                              <img v-if="image !== 'not'" :src="image" />
                              <v-icon v-else size="56" color="#90A4AE" dark>mdi-account-circle</v-icon>
                            </v-avatar>
                          </v-col>
                          <v-col cols="7">
                            <strong v-text="user.name"></strong>
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
              <v-file-input
                label="プロフィール画像"
                @change="selectedFile"
                prepend-icon="mdi-camera"
                chips
                :clearable="false"
                color="#FDD835"
              ></v-file-input>
              <v-textarea
                counter="150"
                rows="2"
                color="#FDD835"
                prepend-icon="mdi-text-account"
                v-model="user.profile"
                label="プロフィール"
                required
              ></v-textarea>
              <v-row justify="end">
                <v-col cols="7" md="5" lg="5" xl="5">
                  <v-btn rounded color="#FFF176" class="mr-4" type="submit">マイページ更新</v-btn>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-form>
      </v-container>
    </v-card>
  </v-container>
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
      this.user.profile_image = e;
      this.image = window.URL.createObjectURL(e);
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
