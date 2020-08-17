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
      <input v-model="current_user.profile" type="text" />
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
import { currentUser } from "../../packs/mixins/currentUser";

export default {
  mixins: [currentUser],
  data() {
    return {
      errors: "",
    };
  },
  methods: {
    selectedFile(e) {
      this.current_user.profile_image = this.$refs.myFiles.files[0];
    },
    updateUser() {
      let formData = new FormData();
      formData.append("user[profile]", this.current_user.profile);
      // まだ画像編集できない、初期値とのバインディング
      // formData.append("current_user[profile_image]", this.current_user.profile_image);
      axios
        .patch(`/api/v1/users/${this.current_user.id}`, formData)
        .then((response) => {
          this.$router.push({
            name: "UsersShowPage",
            params: { id: this.current_user.id },
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
