<template>
  <div>
    <div v-for="image in slideImages" :key="image.index">
      <v-img :src="image" width="0" height="0"></v-img>
    </div>
    <v-carousel cycle height="1000" hide-delimiters :show-arrows="false" dark touchless>
      <v-carousel-item v-for="(slide, i) in slideImages" :key="i" :src="slide" dark></v-carousel-item>
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
import Image1 from "../../../assets/images/back_img_2.jpg";
import Image2 from "../../../assets/images/back_img_3.jpg";
import Image3 from "../../../assets/images/back_img_4.jpg";
import Image4 from "../../../assets/images/back_img_5.jpg";
import Image5 from "../../../assets/images/back_img_6.jpg";
import Image6 from "../../../assets/images/back_img_7.jpg";

import loginForm from "../../components/login/LoginForm.vue";
import SignUp from "../../components/login/SignUp.vue";

export default {
  components: {
    loginForm,
    SignUp,
  },
  data() {
    return {
      slideImages: [Image1, Image2, Image3, Image4, Image5, Image6],
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
  },
  computed: {
    // assetsImage() {
    //   switch (this.$vuetify.breakpoint.name) {
    //     case "xs":
    //       return this.spImages;
    //     case "sm":
    //       return this.spImages;
    //     default:
    //       return this.pcImages;
    //   }
    // },
  },
};
</script>
<style scoped>
</style>
