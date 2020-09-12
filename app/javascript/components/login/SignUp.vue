<template>
  <v-card id="signup" flat color="rgba(0,0,0,0)" width="350" height="395">
    <v-container>
      <p class="text-lg-left">
        <v-btn text class="mr-4 white--text" @click.stop="$emit('login-modal')">
          <v-icon>mdi-chevron-left</v-icon>ログイン
        </v-btn>
      </p>
      <v-form @submit.prevent="signUp">
        <div v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li>
              <font color="red">{{ e }}</font>
            </li>
          </ul>
        </div>
        <v-text-field v-model="user.name" label="名前" prepend-icon="mdi-rename-box" dark required></v-text-field>
        <v-text-field
          v-model="user.email"
          label="メール"
          prepend-icon="mdi-email-multiple"
          dark
          required
        ></v-text-field>
        <v-text-field
          v-model="user.password"
          prepend-icon="mdi-lock"
          hint="6字以上にしてください"
          :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
          counter
          :type="showPassword ? 'text' : 'password'"
          :rules="[rules.required, rules.min]"
          label="パスワード"
          dark
          @click:append="showPassword = !showPassword"
        ></v-text-field>
        <v-text-field
          v-model="user.password_confirmation"
          label="パスワード(確認)"
          prepend-icon="mdi-lock-check"
          append-icon="mdi-eye-off"
          type="password"
          dark
          required
        ></v-text-field>
        <p class="text-lg-right">
          <v-btn text right class="mr-4 white--text" type="submit" absolute>
            新規登録
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
        name: "",
        email: "",
        password: "",
        password_confirmation: "",
      },
      errors: "",
      showPassword: false,
      rules: {
        required: (value) => !!value,
        min: (v) => v.length >= 6 || "6字以上にしてください",
      },
    };
  },
  methods: {
    async signUp() {
      const res = await axios
        .post("/api/v1/auth", this.user)
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
#signup {
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 0.08),
    rgba(0, 0, 0, 0.28)
  );
}
</style>
