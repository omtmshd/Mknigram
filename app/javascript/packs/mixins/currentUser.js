import axios from "axios";

export const currentUser = {
  data() {
    return {
      currentUser: {
        id: Number,
        name: String,
        profile: String,
        profile_image: {
          url: ""
        }
      },
    };
  },
  created() {
    axios
      .get(`/api/v1/users/current.json`)
      .then((response) => (this.currentUser = response.data));
  },
};
