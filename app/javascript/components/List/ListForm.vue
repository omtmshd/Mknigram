<template>
  <div>
    <v-dialog
      persistent
      scrollable
      v-model="dialog"
      @click:outside="$emit('close')"
      :width="dialogWidth"
    >
      <v-card>
        <v-list-item>
          <v-list-item-action>
            <v-icon>mdi-content-save-move-outline</v-icon>
          </v-list-item-action>
          <v-list-item-title class="headline">マイリスト</v-list-item-title>
          <v-list-item-subtitle>保存先...</v-list-item-subtitle>
        </v-list-item>
        <v-card-text class="pa-0" :style="cardHeight">
          <v-hover v-slot:default="{ hover }">
            <v-card
              color="#f5f5f5"
              outlined
              :elevation="hover ? 12 : 2"
              :class="{ 'on-hover': hover }"
              @click.stop="folderNew"
              :width="cardWidth"
              class="mx-auto my-2"
            >
              <v-card-title class="title">リストを作成</v-card-title>
            </v-card>
          </v-hover>
          <list-add-button
            v-for="list_folder in list_folders"
            :key="list_folder.id"
            :list-folder="list_folder"
          ></list-add-button>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";

import ListAddButton from "./ListAddButton.vue";

export default {
  components: {
    ListAddButton,
  },
  data() {
    return {
      list_folders: [],
      dialog: false,
    };
  },
  mounted() {
    this.dialog = true;
    this.setListFolders();
  },
  methods: {
    setListFolders() {
      axios
        .get("/api/v1/list_folders", {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then(({ data }) => {
          this.list_folders = data;
        });
    },
    // リストフォルダ作成
    folderNew() {
      const arr = this.$route.path.split("/");
      arr.pop();
      this.$router.push({
        path: `${arr.join("/")}/folders`,
      });
    },
  },
  computed: {
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "330";
        case "sm":
          return "330";
        default:
          return "450";
      }
    },
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "300";
        case "sm":
          return "300";
        default:
          return "400";
      }
    },
    cardHeight() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "max-height: 450px";
        case "sm":
          return "max-height: 550px";
        default:
          return "max-height: 600px";
      }
    },
  },
};
</script>
<style scoped>
</style>
