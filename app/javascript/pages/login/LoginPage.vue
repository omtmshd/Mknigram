<template>
  <div>
    <div v-for="image in assetsImage" :key="image.index">
      <v-img :src="image" width="0" hight="0"></v-img>
    </div>
    <v-carousel cycle height="1000" hide-delimiters :show-arrows="false" dark touchless>
      <v-carousel-item v-for="(slide, i) in assetsImage" :key="i" :src="slide" dark></v-carousel-item>
    </v-carousel>
    <v-dialog hide-overlay persistent v-model="dialogLogin" width="350">
      <login-form @signup-modal="signupModal"></login-form>
    </v-dialog>
    <v-dialog hide-overlay persistent v-model="dialogSignUp" width="350">
      <sign-up @login-modal="loginModal"></sign-up>
    </v-dialog>
  </div>
</template>
<script>
import imagePc2 from "../../../assets/images/back_pc_2.jpg";
import imagePc6 from "../../../assets/images/back_pc_6.jpg";
import imagePc9 from "../../../assets/images/back_pc_9.jpg";
import imageSp4 from "../../../assets/images/back_sp_4.jpg";
import imageSp5 from "../../../assets/images/back_sp_5.jpg";
import imageSp6 from "../../../assets/images/back_sp_6.jpg";

import loginForm from "../../components/login/LoginForm.vue";
import SignUp from "../../components/login/SignUp.vue";

export default {
  components: {
    loginForm,
    SignUp,
  },
  data() {
    return {
      pcImages: [imagePc2, imagePc6, imagePc9],
      spImages: [imageSp4, imageSp5, imageSp6],
      dialogLogin: true,
      dialogSignUp: false,
    };
  },
  methods: {
    signupModal() {
      this.dialogLogin = false;
      this.dialogSignUp = true;
    },
    loginModal() {
      this.dialogSignUp = false;
      this.dialogLogin = true;
    },
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
  computed: {
    assetsImage() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return this.spImages;
        case "sm":
          return this.spImages;
        case "md":
          return this.pcImages;
        case "lg":
          return this.pcImages;
        case "xl":
          return this.pcImages;
      }
    },
  },
};
</script>
<style scoped>
</style>
