<template>
  <div>
    <form @submit.prevent="$emit('submit')">
      <button type="submit">フォロー解除</button>
    </form>
  </div>
</template>
<script>
import axios from "axios";

export default {};
</script>
<style scoped>
</style>
