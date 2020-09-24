<template>
  <v-dialog
    persistent
    scrollable
    v-model="dialog"
    @click:outside="$emit('close')"
    :width="dialogWidth"
  >
    <v-card class="pa-6">
      <v-card-text>
        <list-folder-form :list-folder="list_folder" :errors="errors" @submit="createListFolder"></list-folder-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";

import ListFolderForm from "./ListFolderForm.vue";

export default {
  components: {
    ListFolderForm,
  },
  data() {
    return {
      list_folder: {
        name: "",
      },
      errors: "",
      dialog: false,
    };
  },
  mounted() {
    this.dialog = true;
  },
  methods: {
    async createListFolder() {
      let formData = new FormData();
      formData.append("list_folder[name]", this.list_folder.name);
      const res = await axios
        .post("/api/v1/list_folders", formData, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      if (res.status !== 201) {
        process.exit();
      }
      const arr = this.$route.path.split("/");
      arr.pop();
      this.$router.push({
        path: `${arr.join("/")}/lists`,
      });
    },
  },
  computed: {
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "250";
        case "sm":
          return "250";
        case "md":
          return "450";
        case "lg":
          return "450";
        case "xl":
          return "450";
      }
    },
  },
};
</script>
