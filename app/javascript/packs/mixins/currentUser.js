import axios from "axios";

export const currentUser = {
  data() {
    return {
      current_user: {
        id: Number,
        name: String
      },
    };
  },
  created() {
    axios
      .get(`/api/v1/users/current.json`)
      .then((response) => (this.current_user = response.data));
  },
};
