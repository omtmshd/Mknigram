<template>
  <div id="overlay" v-on:click="clickEvent">
    <div id="content"></div>
  </div>
</template>
<script>
export default {
  methods: {
    clickEvent: function () {
      this.$emit("from-child");
    },
  },
};
</script>
<style scoped>
</style>
