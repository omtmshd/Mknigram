<template>
  <div>
    <v-btn icon @click.stop="listShow">
      <v-icon>mdi-sticker-plus-outline</v-icon>
      {{listsData.length}}
    </v-btn>

    <v-snackbar
      v-model="snackbar"
      top
      right
      light
      transition="scroll-x-reverse-transition"
      :timeout="2000"
    >
      ログインしてくだい
      <template v-slot:action="{ attrs }">
        <v-btn color="#37474F" text v-bind="attrs" @click="snackbar = false">閉じる</v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: ["userId"],
  data() {
    return {
      snackbar: false,
      listsData: [],
    };
  },
  watch: { $route: "setLists" },
  mounted() {
    this.setLists();
  },
  methods: {
    setLists() {
      axios
        .get(`api/v1/lists?id=${this.$route.params.post_id}`)
        .then(({ data }) => {
          this.listsData = data;
        });
    },
    listShow() {
      if (this.userId > 0) {
        let arr = this.$route.path.split("/");
        let path_name = arr.pop();
        if (path_name !== "lists" || path_name !== "folders") {
          this.$router.push({
            path: `${this.$route.path}/lists`,
          });
        }
      } else {
        this.snackbar = true;
      }
    },
  },
};
</script>
