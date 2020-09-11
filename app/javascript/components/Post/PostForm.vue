<template>
  <v-container>
    <v-card class="mx-auto">
      <v-container>
        <v-form @submit.prevent="$emit('submit')">
          <div v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li>
                <font color="red">{{ e }}</font>
              </li>
            </ul>
          </div>
          <v-row justify="center">
            <v-col cols="12" md="6" lg="6" xl="6">
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
                </v-col>
              </v-row>
            </v-col>
            <v-col cols="12" md="6" lg="6" xl="6">
              <v-row justify="center">
                <v-col cols="9">
                  <v-treeview
                    :items="categoriesData"
                    v-model="post.categories"
                    selection-type="leaf"
                    selected-color="#FDD835"
                    dense
                    activatable
                    expand-icon="mdi-chevron-down"
                    open-on-click
                    return-object
                    selectable
                    transition
                  ></v-treeview>
                  <v-row justify="end" align="end">
                    <v-col cols="4">
                      <v-btn rounded color="#FFF176" class="mr-4" type="submit">投稿する</v-btn>
                    </v-col>
                  </v-row>
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
      categories: [],
      category_ids: [],
    },
    errors: "",
  },
  data() {
    return {
      categoriesData: [],
      image: "",
    };
  },
  mounted() {
    this.getCategories();
  },
  updated() {
    // 編集画面で画像をセット
    if (this.post.id > 0 && this.image === "") {
      this.image = this.post.post_image.url;
    }
  },
  methods: {
    // ファイルを代入
    selectedFile(e) {
      if (!e) {
        this.post.post_image = null;
        this.image = null;
      } else {
        this.post.post_image = e;
        this.image = window.URL.createObjectURL(e);
      }
      this.$emit("change-file");
    },
    getCategories() {
      axios.get("/api/v1/categories").then(({ data }) => {
        this.categoriesData = data;
      });
    },
  },
};
</script>
<style scoped>
</style>
