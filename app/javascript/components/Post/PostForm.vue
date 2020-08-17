<template>
  <form @submit.prevent="$emit('submit')">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li>
          <font color="red">{{ e }}</font>
        </li>
      </ul>
    </div>
    <div>
      <label>タイトル</label>
      <input v-model="post.title" type="text" />
    </div>
    <div>
      <label>レシピ</label>
      <input v-model="post.body" type="text" />
    </div>
    <div>
      <label>写真</label>
      <input ref="myFiles" id="file" type="file" @change="selectedFile" />
    </div>
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

    <button type="submit">投稿する</button>
  </form>
</template>
<script>
import axios from "axios";

export default {
  props: {
    post: {
      title: "",
      body: "",
      post_image: String,
      category_ids: [],
      categories: [{}, {}, {}],
    },
    errors: "",
  },
  data() {
    return {
      parents: [],
      children: [],
      grandchildren: [],
    };
  },
  created() {
    this.setParents();
  },
  updated() {
    if (this.children.length == 0 && this.post.id > 0) {
      this.setChildren();
      this.setGrandchildren();
    }
  },
  methods: {
    // ファイルを代入
    selectedFile(e) {
      this.post.post_image = this.$refs.myFiles.files[0];
    },
    // 第1層カテゴリー取得
    setParents() {
      axios
        .get("/api/v1/categories/parents.json")
        .then((response) => (this.parents = response.data));
    },
    // 子カテゴリー取得
    setChildren() {
      axios
        .get(`/api/v1/categories/${this.post.categories[0].id}/children.json`)
        .then((response) => (this.children = response.data));
      if (this.grandchildren.length != []) {
        this.post.categories[2].id = -1;
        this.post.categories[2].name = "";
        this.grandchildren = [];
      }
    },
    // 孫カテゴリー取得
    setGrandchildren() {
      axios
        .get(`/api/v1/categories/${this.post.categories[1].id}/children.json`)
        .then((response) => (this.grandchildren = response.data));
    },
  },
};
</script>
<style>
</style>
