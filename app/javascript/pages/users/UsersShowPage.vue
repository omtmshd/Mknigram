<template>
  <div>
    <p>{{ user.id }}</p>
    <p>{{ user.name}}</p>
    <p>{{ user.profile}}</p>
    <div v-if="user.profile_image">{{ user.profile_image }}</div>
    <div v-else>
      <img src="/assets/default.png" />
    </div>
    <following-count></following-count>
    <followers-count ref="child"></followers-count>
    <div v-if="current_user.id!==user.id">
      <template v-if="follow_status">
        <user-unfollow :user="user" @submit="userUnfollow"></user-unfollow>
      </template>
      <template v-else>
        <user-follow :user="user" @submit="userFollow"></user-follow>
      </template>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import FollowingCount from "../../components/User/FollowingCount.vue";
import FollowersCount from "../../components/User/FollowersCount.vue";
import UserFollow from "../../components/User/UserFollow.vue";
import UserUnfollow from "../../components/User/UserUnfollow.vue";

export default {
  components: { FollowingCount, FollowersCount, UserFollow, UserUnfollow },
  data() {
    return {
      user: {},
      follow_status: {},
    };
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then((response) => (this.user = response.data));
    this.followStatus();
  },
  methods: {
    userFollow() {
      axios.post("/api/v1/relationships", this.user);
      this.$refs.child.$emit("updateFollowers");
      this.follow_status = true;
    },
    userUnfollow() {
      axios.delete(`/api/v1/relationships/${this.user.id}`);
      this.$refs.child.$emit("updateFollowers");
      this.follow_status = false;
    },
    followStatus() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}/following_status.json`)
        .then((response) => (this.follow_status = response.data));
    },
  },
};
</script>
<style scoped>
</style>
