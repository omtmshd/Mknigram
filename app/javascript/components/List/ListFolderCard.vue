<template>
  <div>
    <v-col>
      <v-hover v-slot:default="{ hover }">
        <v-card
          :elevation="hover ? 12 : 2"
          :class="{ 'on-hover': hover }"
          flat
          color="rgba(255, 255, 255, .3)"
        >
          <v-row dense>
            <v-col cols="8">
              <v-card
                v-if="posts.length >= 1"
                width="232"
                height="200"
                flat
                color="rgba(0, 0, 0, .3)"
              >
                <v-img width="232" height="200" :src="posts[0].post_image.url"></v-img>
              </v-card>
            </v-col>
            <v-col cols="4">
              <v-card width="115" height="98" flat color="rgba(0, 0, 0, .05)" class="mb-1">
                <v-img
                  v-if="posts.length >= 2"
                  width="116"
                  height="100"
                  :src="posts[1].post_image.url"
                ></v-img>
              </v-card>
              <v-card width="115" height="98" flat color="rgba(0, 0, 0, .05)">
                <v-img
                  v-if="posts.length >= 3"
                  width="116"
                  height="100"
                  :src="posts[2].post_image.url"
                ></v-img>
              </v-card>
            </v-col>
          </v-row>
          <v-card-title class="font-weight-black">{{listFolder.name}}</v-card-title>
          <v-card-subtitle class="pt-0 pb-1 text-sm-caption">{{lists.length}} 品</v-card-subtitle>
        </v-card>
      </v-hover>
    </v-col>
  </div>
</template>
<script>
import axios from "axios";

export default {
  props: {
    listFolder: {
      id: "",
      name: "",
    },
  },
  data() {
    return {
      lists: [],
      posts: [],
    };
  },
  mounted() {
    this.setLists();
  },
  methods: {
    async setLists() {
      await axios
        .get(`/api/v1/lists/${this.listFolder.id}`)
        .then(({ data }) => {
          this.lists = data;
        });
      this.getPosts();
    },
    async getPosts() {
      for (let i = 0; i < this.listsLength; i++) {
        await axios
          .get(`/api/v1/posts/${this.lists[i].post_id}`)
          .then(({ data }) => {
            this.posts.push(data);
          });
      }
    },
  },
  computed: {
    listsLength() {
      if (this.lists.length < 3) {
        return this.lists.length;
      } else {
        return 3;
      }
    },
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "300";
        case "sm":
          return "300";
        case "md":
          return "400";
        case "lg":
          return "400";
        case "xl":
          return "400";
      }
    },
  },
};
</script>
<style scoped>
.col {
  padding: 1em;
}
.col-4,
.col-8 {
  padding: 0.1em;
}
</style>
