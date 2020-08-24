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
          {{image}}
          <v-file-input @change="selectedFile" label="写真"></v-file-input>
          <v-img
            v-if="image !== 'not'"
            :src="image"
            aspect-ratio="1.7"
            max-width="400"
            min-width="400"
            contain
          ></v-img>
          <v-text-field v-model="post.title" label="タイトル" required></v-text-field>
          <v-textarea v-model="post.body" label="レシピ" required></v-textarea>
          <v-select
            v-model="post.categories[0]"
            :items="parents"
            item-text="name"
            item-value="id"
            chips
            return-object
            @change="setChildren()"
            label="メインカテゴリー"
          />
          <v-select
            v-model="post.categories[1]"
            :items="children"
            item-text="name"
            item-value="id"
            chips
            return-object
            no-data-text="カテゴリーがありません"
            @change="setGrandchildren()"
            label="サブカテゴリー"
          />
          <v-select
            v-model="post.categories[2]"
            :items="grandchildren"
            item-text="name"
            item-value="id"
            chips
            return-object
            no-data-text="カテゴリーがありません"
            label="サブカテゴリー2"
          />

          <v-btn class="mr-4" type="submit">投稿する</v-btn>
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
      image: "not",
    };
  },
  created() {
    this.setParents();
  },
  updated() {
    // 編集画面で1度だけ実行
    if (Number(this.post.id) > 0 && this.children.length === 0) {
      this.setChildren();
      this.setGrandchildren();
    }
    if (Number(this.post.id) > 0 && this.image !== this.post.post_image.url) {
      this.image = this.post.post_image.url;
    }
  },
  methods: {
    // ファイルを代入
    selectedFile(e) {
      this.post.post_image = e;
      this.image = window.URL.createObjectURL(e);
      this.$emit("changeFile");
    },
    // 第1層カテゴリー取得
    setParents() {
      axios
        .get("/api/v1/categories/parents.json")
        .then((response) => (this.parents = response.data));
    },
    // 子カテゴリー取得
    setChildren() {
      if (Number(this.post.categories[0].id) > 0) {
        axios
          .get(`/api/v1/categories/${this.post.categories[0].id}/children.json`)
          .then((response) => (this.children = response.data));
        if (this.grandchildren.length != []) {
          // 孫カテゴリー初期化
          this.post.categories[2] = { id: "", name: "" };
          this.grandchildren = [];
        }
      }
    },
    // 孫カテゴリー取得
    setGrandchildren() {
      if (Number(this.post.categories[1].id) > 0) {
        axios
          .get(`/api/v1/categories/${this.post.categories[1].id}/children.json`)
          .then((response) => (this.grandchildren = response.data));
      }
    },
  },
};
</script>
<style scoped>
</style>
