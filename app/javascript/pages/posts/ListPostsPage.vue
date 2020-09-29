<template>
  <div>
    <router-view></router-view>
    <v-card color="rgba(0,0,0,0)" flat class="mx-auto" :width="cardWidth" min-height="100vh">
      <v-card-title class="font-weight-bold text-h3 my-5">
        {{listFolder.name}}
        <span class="text-sm-caption ml-4">({{listFolder.lists.length}} 品)</span>
        <v-spacer></v-spacer>
        <v-dialog
          v-model="dialog"
          transition="slide-x-reverse-transition"
          persistent
          :width="dialogWidth"
        >
          <v-card class="pa-6">
            <v-card-text>
              <list-folder-form
                :list-folder="listFolder"
                :errors="errors"
                :delete-form="deleteForm"
                @submit="editListFolder"
                @cancel="cancel"
                @delete-cancel="deleteForm = false"
                @delete-show="deleteForm = true"
                @delete-lists="deleteLists"
              ></list-folder-form>
            </v-card-text>
          </v-card>
        </v-dialog>

        <v-btn icon v-if="listFolder.user_id === currentUser.id" large @click="dialog = true">
          <v-icon>mdi-playlist-edit</v-icon>
        </v-btn>
      </v-card-title>
      <v-card-subtitle>
        <user-avatar :user-id="listFolder.user_id"></user-avatar>
      </v-card-subtitle>
      <v-divider class="mx-3"></v-divider>
      <v-row justify="center">
        <v-col>
          <posts-index-image v-for="postFirst in postsFirst" :key="postFirst.id" :post="postFirst"></posts-index-image>
        </v-col>
        <v-col>
          <posts-index-image v-for="postScond in postsScond" :key="postScond.id" :post="postScond"></posts-index-image>
        </v-col>
        <v-col>
          <posts-index-image v-for="postThird in postsThird" :key="postThird.id" :post="postThird"></posts-index-image>
        </v-col>
      </v-row>
      <infinite-loading @infinite="infiniteListPosts" :identifier="infiniteId" spinner="spiral">
        <div slot="spinner"></div>
        <div slot="no-more"></div>
        <div slot="no-results"></div>
      </infinite-loading>
      <v-btn fixed dark fab bottom right color="#263238" @click="$vuetify.goTo(0)">
        <v-icon>mdi-chevron-double-up</v-icon>
      </v-btn>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";

import PostsIndexImage from "../../components/Post/PostsIndexImage.vue";
import UserAvatar from "../../components/User/UserAvatar.vue";
import ListFolderForm from "../../components/List/ListFolderForm.vue";

export default {
  components: { PostsIndexImage, UserAvatar, ListFolderForm },
  data() {
    return {
      listFolder: {
        id: "",
        user_id: "",
        name: "",
        lists: [],
      },
      errors: "",
      postsFirst: [],
      postsScond: [],
      postsThird: [],
      listPostsNumber: 0,
      infiniteId: +new Date(),
      dialog: false,
      deleteForm: false,
    };
  },
  computed: {
    watchId() {
      return this.$route.params.id;
    },
  },
  watch: { watchId: "updatePosts" },
  mounted() {
    this.setListFolder();
  },
  methods: {
    updatePosts() {
      this.postsFirst = [];
      this.postsScond = [];
      this.postsThird = [];
      this.listPostsNumber = 0;
      this.infiniteId += 1;
      this.setListFolder();
    },
    setListFolder() {
      axios
        .get(`/api/v1/list_folders/${this.$route.params.id}`)
        .then(({ data }) => {
          this.listFolder = data;
        });
    },
    infiniteListPosts($state) {
      if (this.listPostsNumber > -1) {
        axios
          .get(
            `/api/v1/list_folders/${this.$route.params.id}/posts?data_id=${this.listPostsNumber}`
          )
          .then(({ data }) => {
            for (let i = 0; i < data.length; i++) {
              switch ((i + 1) % 3) {
                case 1:
                  this.postsFirst.push(data[i]);
                  break;
                case 2:
                  this.postsScond.push(data[i]);
                  break;
                case 0:
                  this.postsThird.push(data[i]);
                  break;
              }
            }
            if (15 > data.length) {
              this.listPostsNumber = -1;
            } else {
              this.listPostsNumber += 15;
            }
            $state.loaded();
          });
      }
    },
    async editListFolder() {
      if (this.listFolder.user_id === this.currentUser.id) {
        let formData = new FormData();
        formData.append("list_folder[name]", this.listFolder.name);
        const res = await axios
          .patch(`/api/v1/list_folders/${this.listFolder.id}`, formData, {
            headers: {
              "access-token": localStorage.getItem("access-token"),
              uid: localStorage.getItem("uid"),
              client: localStorage.getItem("client"),
            },
          })
          .catch((error) => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
        if (res.status !== 200) {
          process.exit();
        }
        this.cancel();
      }
    },
    async deleteLists() {
      if (this.listFolder.user_id === this.currentUser.id) {
        const res = await axios.delete(
          `/api/v1/list_folders/${this.listFolder.id}`,
          {
            headers: {
              "access-token": localStorage.getItem("access-token"),
              uid: localStorage.getItem("uid"),
              client: localStorage.getItem("client"),
            },
          }
        );
        if (res.status !== 200) {
          process.exit();
        }
        this.$router.push(`/users/${this.listFolder.user_id}/list_folders`);
      }
    },
    cancel() {
      this.setListFolder();
      this.dialog = false;
    },
  },
  computed: {
    watchId() {
      return this.$route.params.id;
    },
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "320";
        case "sm":
          return "950";
        default:
          return "1230";
      }
    },
    dialogWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return "250";
        case "sm":
          return "250";
        default:
          return "450";
      }
    },
  },
};
</script>
<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: 0.5s;
}
.col {
  padding: 0;
}
</style>
