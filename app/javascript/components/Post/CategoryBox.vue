<template>
  <div>
    <div v-for="c in categories" :key="c.id">
      <p>{{ c.name }}</p>
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      categories: {},
    };
  },
  mounted() {
    axios
      .get("/api/v1/categories.json")
      .then((response) => (this.categories = response.data));
  },
};
</script>
<style scoped>
</style>
