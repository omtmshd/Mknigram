<template>
  <div>
    <div v-if="categoryIndex">
      <v-list>
        <v-list-item link v-if="category.parent" @click="searchPosts(category.parent.id)">
          <v-list-item-action>
            <v-icon color="#FBC02D">mdi-chevron-left</v-icon>
          </v-list-item-action>
          <v-list-item-title>
            {{category.parent.name}}
            <span class="text--disabled">({{category.parent.posts_count}}品)</span>
          </v-list-item-title>
        </v-list-item>
        <v-list-item link v-else @click="searchPosts(0)">
          <v-list-item-action>
            <v-icon color="#FBC02D">mdi-chevron-left</v-icon>
          </v-list-item-action>
          <v-list-item-title>カテゴリー一覧</v-list-item-title>
        </v-list-item>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title class="title">
              {{category.name}}
              <span class="text--disabled">({{category.posts_count}}品)</span>
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </div>
    <div v-else>
      <v-list>
        <v-list-item>
          <v-list-item-action>
            <v-icon color="#FBC02D">mdi-chevron-triple-down</v-icon>
          </v-list-item-action>
          <v-list-item-title>カテゴリーを選択</v-list-item-title>
        </v-list-item>
      </v-list>
    </div>
    <v-divider></v-divider>
    <v-list dense nav>
      <v-list-item
        v-for="sibling in category.siblings"
        :key="sibling.id"
        link
        @click="searchPosts(sibling.id)"
      >
        <v-list-item-title>
          {{ sibling.name }}
          <span class="text--secondary">({{sibling.posts_count}}品)</span>
        </v-list-item-title>
        <v-list-item-action>
          <v-icon>mdi-chevron-right</v-icon>
        </v-list-item-action>
      </v-list-item>
    </v-list>

    <v-list dense nav>
      <v-list-item
        v-for="child in category.children"
        :key="child.id"
        link
        @click="searchPosts(child.id)"
      >
        <v-list-item-title>
          {{ child.name }}
          <span class="text--secondary">({{child.posts_count}}品)</span>
        </v-list-item-title>
        <v-list-item-action>
          <v-icon>mdi-chevron-right</v-icon>
        </v-list-item-action>
      </v-list-item>
    </v-list>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      categoryIndex: true,
      category: {
        id: "",
        name: "",
        children: [],
        siblings: [],
        parent: {},
      },
    };
  },
  mounted() {
    this.setCategories();
  },
  watch: { $route: "setCategories" },
  methods: {
    setCategories() {
      if (Number(this.$route.params.id) === 0) {
        axios.get("/api/v1/categories/parents").then(({ data }) => {
          this.category.children = data;
          this.categoryIndex = false;
        });
      } else {
        axios
          .get(`/api/v1/categories/${this.$route.params.id}/children`)
          .then(({ data }) => {
            this.category = data;
            this.categoryIndex = true;
          });
      }
    },
    searchPosts(i) {
      if (this.$route.path !== `/categories/${i}/search`) {
        this.$router.push(`/categories/${i}/search`);
      }
    },
  },
};
</script>
<style scoped>
</style>
