<template>
  <div>
    <form @submit.prevent="$emit('submit')">
      <button type="submit">フォローする</button>
    </form>
  </div>
</template>
<script>
import axios from "axios";

export default {};
</script>
<style scoped>
</style>
