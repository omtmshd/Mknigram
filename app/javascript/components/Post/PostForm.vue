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
      <label>Title</label>
      <input v-model="post.title" type="text" />
    </div>
    <div>
      <label>Body</label>
      <input v-model="post.body" type="text" />
    </div>
    <div>
      <label>Image</label>
      <input ref="myFiles" type="file" @change="selectedFile" />
    </div>
    <button type="submit">Commit</button>
  </form>
</template>
<script>
export default {
  props: {
    post: {},
    errors: "",
  },
  methods: {
    selectedFile(e) {
      this.post.post_image = this.$refs.myFiles.files[0];
    },
  },
};
</script>
<style>
</style>
