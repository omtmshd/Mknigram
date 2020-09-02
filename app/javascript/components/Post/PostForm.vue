<template>
  <v-container>
    <v-card class="mx-auto" max-width="400">
      <v-container>
        <v-form @submit.prevent="$emit('submit')">
          <div v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li>
                <font color="red">{{ e }}</font>
              </li>
            </ul>
          </div>
          <v-card class="mx-auto" width="320">
            <v-img
              :src="image"
              aspect-ratio="1.2"
              class="white--text align-end"
              gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
            >
              <v-card-title v-text="post.title"></v-card-title>
            </v-img>
            <v-breadcrumbs :items="post.categories" text="name">
              <template v-slot:item="{ item }">
                <v-breadcrumbs-item>{{ item.name }}</v-breadcrumbs-item>
              </template>
            </v-breadcrumbs>
            <v-card-text>{{ post.body }}</v-card-text>
          </v-card>
          <v-row justify="center">
            <v-col cols="9">
              <v-file-input
                dense
                @change="selectedFile"
                label="写真"
                prepend-icon="mdi-camera"
                chips
                :clearable="false"
                color="#FDD835"
              ></v-file-input>

              <v-text-field
                counter="20"
                dense
                v-model="post.title"
                label="タイトル"
                required
                color="#FDD835"
                prepend-icon="mdi-chef-hat"
              ></v-text-field>

              <v-textarea
                counter="250"
                dense
                v-model="post.body"
                label="レシピ"
                required
                rows="2"
                color="#FDD835"
                prepend-icon="mdi-silverware"
              ></v-textarea>

              <v-select
                dense
                solo
                v-model="post.categories[0]"
                :items="parents"
                item-text="name"
                item-value="id"
                return-object
                @change="selectParents()"
                label="メインカテゴリー"
                color="#FDD835"
                item-color="#FDD835"
                prepend-icon="mdi-menu-right"
              />
              <v-select
                dense
                solo
                v-model="post.categories[1]"
                :items="children"
                item-text="name"
                item-value="id"
                return-object
                no-data-text="カテゴリーがありません"
                @change="selectChildren()"
                label="サブカテゴリー"
                color="#FDD835"
                item-color="#FDD835"
                prepend-icon="mdi-menu-right"
              />
              <v-select
                dense
                solo
                v-model="post.categories[2]"
                :items="grandchildren"
                item-text="name"
                item-value="id"
                return-object
                no-data-text="カテゴリーがありません"
                label="サブカテゴリー2"
                color="#FDD835"
                item-color="#FDD835"
                prepend-icon="mdi-menu-right"
              />
              <v-row justify="end">
                <v-col cols="4">
                  <v-btn rounded color="#FFF176" class="mr-4" type="submit">投稿する</v-btn>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-form>
      </v-container>
    </v-card>
  </v-container>
</template>
<script>
import axios from "axios";

export default {
  props: {
    post: {
      title: "",
      body: "",
      post_image: "",
      category_ids: [],
      categories: [
        { id: "", name: "" },
        { id: "", name: "" },
        { id: "", name: "" },
      ],
    },
    errors: "",
  },
  data() {
    return {
      parents: [],
      children: [],
      grandchildren: [],
      image: "",
    };
  },
  mounted() {
    this.setParents();
    if (this.post.id > 0) {
      this.setChildren();
      this.setGrandchildren();
    }
  },
  updated() {
    // 編集画面で画像をセット
    if (this.post.id > 0 && this.image !== this.post.post_image.url) {
      this.image = this.post.post_image.url;
    }
  },
  methods: {
    // ファイルを代入
    selectedFile(e) {
      this.post.post_image = e;
      this.image = window.URL.createObjectURL(e);
      this.$emit("change-file");
    },
    // 第1層カテゴリー取得
    setParents() {
      axios
        .get("/api/v1/categories/parents.json")
        .then((response) => (this.parents = response.data));
    },
    // 子カテゴリー取得
    setChildren() {
      if (this.post.categories[0] !== null) {
        axios
          .get(`/api/v1/categories/${this.post.categories[0].id}/children.json`)
          .then((response) => (this.children = response.data));
      }
    },
    // 孫カテゴリー取得
    setGrandchildren() {
      if (this.post.categories[1] !== null) {
        axios
          .get(`/api/v1/categories/${this.post.categories[1].id}/children.json`)
          .then((response) => (this.grandchildren = response.data));
      }
    },
    resetChildren() {
      this.post.categories[1] = { id: "", name: "" };
    },
    resetGrandchildren() {
      this.post.categories[2] = { id: "", name: "" };
    },
    selectParents() {
      this.setChildren();
      this.resetChildren();
      this.resetGrandchildren();
    },
    selectChildren() {
      this.setGrandchildren();
      this.resetGrandchildren();
    },
  },
};
</script>
<style scoped>
</style>
