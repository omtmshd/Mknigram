<template>
  <div>
    <v-row justify="center" class="mx-auto">
      <list-folder-card
        v-for="list_folder in list_folders"
        :key="list_folder.id"
        :list-folder="list_folder"
      ></list-folder-card>
    </v-row>
  </div>
</template>
<script>
import axios from "axios";

import ListFolderCard from "./ListFolderCard.vue";

export default {
  components: {
    ListFolderCard,
  },
  data() {
    return {
      list_folders: [],
    };
  },
  mounted() {
    this.setListFolders();
  },
  methods: {
    setListFolders() {
      axios
        .get(`/api/v1/list_folders/${this.$route.params.id}`)
        .then(({ data }) => {
          this.list_folders = data;
        });
    },
  },
  computed: {
    imageWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "108";
        case "sm":
          return "216";
        case "md":
          return "336";
        case "lg":
          return "336";
        case "xl":
          return "336";
      }
    },
  },
};
</script>
