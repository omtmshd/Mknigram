<template>
  <div>
    <div v-for="image in assetsImage" :key="image.index">
      <v-img :src="image" width="0" height="0"></v-img>
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
import ImagePc2 from "../../../assets/images/back_pc_2.jpg";
import ImagePc6 from "../../../assets/images/back_pc_6.jpg";
import ImagePc9 from "../../../assets/images/back_pc_9.jpg";
import ImageSp4 from "../../../assets/images/back_sp_4.jpg";
import ImageSp5 from "../../../assets/images/back_sp_5.jpg";
import ImageSp6 from "../../../assets/images/back_sp_6.jpg";

import loginForm from "../../components/login/LoginForm.vue";
import SignUp from "../../components/login/SignUp.vue";

export default {
  components: {
    loginForm,
    SignUp,
  },
  data() {
    return {
      pcImages: [ImagePc2, ImagePc6, ImagePc9],
      spImages: [ImageSp4, ImageSp5, ImageSp6],
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
