<template>
  <v-container>
    <v-form @submit.prevent="formSubmit">
      <v-card class="mx-auto" width="550" color="rgba(255,255,255,.85)" flat>
        <v-img
          :src="image"
          min-height="350"
          class="white--text align-end"
          gradient="to bottom, rgba(0,0,0,0), rgba(0,0,0,.3)"
        >
          <v-card-title>
            <v-text-field counter="20" dense dark v-model="post.title" label="タイトル" required></v-text-field>

            <v-spacer></v-spacer>

            <v-file-input
              style="max-width: 30px;"
              dark
              dense
              @change="selectedFile"
              label="写真"
              prepend-icon="mdi-camera"
              hide-input
              :clearable="false"
            ></v-file-input>
          </v-card-title>
        </v-img>

        <v-card-text class="py-3">
          <div v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li>
                <font color="red">{{ e }}</font>
              </li>
            </ul>
          </div>
          <v-textarea
            counter="250"
            dense
            v-model="post.body"
            color="black"
            label="レシピ"
            required
            rows="2"
          ></v-textarea>
          <v-btn text @click.stop="dialog=true">カテゴリーを選択</v-btn>

          <v-breadcrumbs :items="post.categories" text="name" class="py-1">
            <template v-slot:item="{ item }">
              <v-breadcrumbs-item>{{ item.name }}</v-breadcrumbs-item>
            </template>
          </v-breadcrumbs>
        </v-card-text>

        <v-card-actions>
          <v-btn text class="ml-4" @click="cancel">キャンセル</v-btn>
          <v-spacer></v-spacer>

          <v-btn dark class="mr-4" :disabled="processing" type="submit">投稿する</v-btn>
        </v-card-actions>
      </v-card>
      <v-dialog v-model="dialog" width="350" scrollable>
        <v-card flat>
          <v-card-text style="max-height: 600px;">
            <v-treeview
              :items="categoriesData"
              v-model="post.categories"
              selection-type="leaf"
              selected-color="black"
              dense
              activatable
              expand-icon="mdi-chevron-down"
              open-on-click
              return-object
              selectable
              transition
            ></v-treeview>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn text @click.stop="dialog=false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-form>
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
      user_id: "",
    },
    errors: "",
  },
  data() {
    return {
      categoriesData: [],
      image: "",
      dialog: false,
      processing: false,
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
    cancel() {
      this.$router.push("/");
    },
    formSubmit() {
      this.$emit("submit");
      if (this.processing) return;
      this.processing = true;
      this.doSomething().then(() => {
        this.processing = false;
      });
    },
    doSomething() {
      return new Promise((resolve) => {
        setTimeout(() => {
          console.log(`Submitted on ${new Date()}`);
          resolve();
        }, 1000);
      });
    },
  },
};
</script>
<style scoped>
</style>
