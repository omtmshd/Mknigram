<template>
  <v-breadcrumbs :items="categories" text="name" class="px-0 py-1">
    <template v-slot:item="{ item }">
      <v-breadcrumbs-item>
        <v-btn
          small
          text
          class="px-0"
          color="#616161"
          @click.stop="categorySearch(item.id)"
        >{{ item.name }}</v-btn>
      </v-breadcrumbs-item>
    </template>
  </v-breadcrumbs>
</template>
<script>
import axios from "axios";

export default {
  props: ["postId"],
  data() {
    return {
      categories: [],
    };
  },
  mounted() {
    this.setCategories();
  },
  methods: {
    setCategories() {
      axios.get(`/api/v1/posts/${this.postId}/categories`).then(({ data }) => {
        this.categories = data;
      });
    },
    categorySearch(i) {
      if (this.$route.path !== `/categories/${i}/search`) {
        this.$router.push(`/categories/${i}/search`);
      }
    },
  },
};
</script>
<style scoped>
</style>
