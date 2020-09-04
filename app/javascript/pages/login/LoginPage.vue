<template>
  <v-container>
    <v-card class="mx-auto" max-width="400">
      <v-container>
        <v-form @submit.prevent="loginForm()">
          <div v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li>
                <font color="red">{{ e }}</font>
              </li>
            </ul>
          </div>
          <v-text-field
            v-model="user.email"
            label="メール"
            prepend-icon="mdi-email-multiple"
            color="#FDD835"
            required
          ></v-text-field>
          <v-text-field
            v-model="user.password"
            label="パスワード"
            prepend-icon="mdi-lock"
            color="#FDD835"
            required
          ></v-text-field>
          <v-btn rounded color="#FFF176" class="mr-4" type="submit">ログイン</v-btn>
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
      user: {
        email: "",
        password: "",
      },
      errors: "",
    };
  },
  methods: {
    async loginForm() {
      const res = await axios
        .post("/api//v1/auth/sign_in", this.user)
        .then((response) => {
          // レスポンスで返ってきた、認証に必要な情報をlocalStorageに保存
          localStorage.setItem(
            "access-token",
            response.headers["access-token"]
          );
          localStorage.setItem("expiry", response.headers.expiry);
          localStorage.setItem("client", response.headers.client);
          localStorage.setItem("uid", response.headers.uid);
          localStorage.setItem("token-type", response.headers["token-type"]);
          return response;
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      if (res.status !== 200) {
        process.exit();
      }
      this.$router.push({ path: "/" });
    },
  },
};
</script>
<style scoped>
</style>
