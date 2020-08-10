<template>
  <form @submit.prevent="updateUser">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li>
          <font color="red">{{ e }}</font>
        </li>
      </ul>
    </div>
    <div>
      <label>プロフィール</label>
      <input v-model="user.profile" type="text" />
    </div>
    <div>
      <label>プロフィール画像</label>
      <input ref="myFiles" type="file" @change="selectedFile" />
    </div>
    <button type="submit">Commit</button>
  </form>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      user: {},
      errors: "",
    };
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then((response) => (this.user = response.data));
  },
  methods: {
    selectedFile(e) {
      this.user.profile_image = this.$refs.myFiles.files[0];
    },
    updateUser() {
      let formData = new FormData();
      formData.append("user[profile]", this.user.profile);
      // まだ画像編集できない、初期値とのバインディング
      // formData.append("user[profile_image]", this.user.profile_image);
      axios
        .patch(`/api/v1/users/${this.user.id}`, formData)
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
