<template>
  <div>
    <v-form @submit.prevent="$emit('submit')">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li>
            <font color="red">{{ e }}</font>
          </li>
        </ul>
      </div>

      <template v-if="!deleteForm">
        <v-text-field color="black" v-model="listFolder.name" counter="25" label="リストの名前"></v-text-field>
        <p>
          <v-btn
            text
            v-if="$route.name === 'ListPostsPage'"
            @click="$emit('delete-show')"
            color="#E53935"
          >削除</v-btn>
        </p>
        <p>
          <v-btn text @click.stop="$emit('cancel')" left absolute>キャンセル</v-btn>
          <v-btn text type="submit" right absolute>
            作成
            <v-icon>mdi-chevron-double-right</v-icon>
          </v-btn>
        </p>
      </template>
      <template v-else>
        <v-text-field color="black" v-model="listFolder.name" counter="25" label="リストの名前" disabled></v-text-field>
        <p>本当に削除しますか？</p>
        <p>
          <v-btn text @click.stop="$emit('delete-cancel')" left absolute>キャンセル</v-btn>
          <v-btn text @click.stop="$emit('delete-lists')" right absolute color="#E53935">
            削除
            <v-icon>mdi-chevron-double-right</v-icon>
          </v-btn>
        </p>
      </template>
    </v-form>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    listFolder: {
      name: "",
    },
    errors: "",
    deleteForm: false,
  },
};
</script>
