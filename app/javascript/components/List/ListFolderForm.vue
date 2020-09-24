<template>
  <div>
    <v-form @submit.prevent="$emit('submit')">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li>
            <font color="red">{{ e }}</font>
          </li>
        </ul>
      </div>
      <v-text-field color="black" v-model="listFolder.name" counter="25" label="リストの名前"></v-text-field>
      <p>
        <v-btn text @click.stop="listShow" left absolute>キャンセル</v-btn>
        <v-btn text type="submit" right absolute>
          作成
          <v-icon>mdi-chevron-double-right</v-icon>
        </v-btn>
      </p>
    </v-form>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    listFolder: {
      name: "",
    },
    errors: "",
  },
  methods: {
    listShow() {
      const arr = this.$route.path.split("/");
      arr.pop();
      this.$router.push({
        path: `${arr.join("/")}/lists`,
      });
    },
  },
};
</script>
