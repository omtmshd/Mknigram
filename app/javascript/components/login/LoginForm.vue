<template>
  <v-card id="login" flat color="rgba(0,0,0,0)" width="350" height="270">
    <v-container>
      <p class="text-lg-left">
        <v-btn text class="mr-4 white--text" @click.stop="$emit('signup-modal')">
          <v-icon>mdi-chevron-left</v-icon>新規登録
        </v-btn>
      </p>
      <v-form @submit.prevent="loginForm">
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
          dark
          required
        ></v-text-field>
        <v-text-field v-model="user.password" label="パスワード" prepend-icon="mdi-lock" dark required></v-text-field>
        <p class="text-lg-right">
          <v-btn text right class="mr-4 white--text" type="submit" absolute>
            ログイン
            <v-icon>mdi-chevron-right</v-icon>
          </v-btn>
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
#login {
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 0.08),
    rgba(0, 0, 0, 0.32)
  );
}
</style>
