import axios from 'axios'

export const currentUser = {
  data() {
    return {
      currentUser: {
        id: "",
        name: "",
        profile: "",
        profile_image: {
          url: ""
        }
      },
    };
  },
  created() {
    this.setCurrentUser()
  },
  watch: { $route: "setCurrentUser" },
  methods: {
    setCurrentUser() {
      axios
        .get(`/api/v1/users/current.json`, {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client'),
          },
        })
        .then((response) => (this.currentUser = response.data));
    }
  }
};
