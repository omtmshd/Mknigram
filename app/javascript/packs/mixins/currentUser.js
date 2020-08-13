import axios from "axios";

export const currentUser = {
  data() {
    return {
      current_user: {},
    };
  },
  created() {
    axios
      .get(`/api/v1/users/current.json`)
      .then((response) => (this.current_user = response.data));
  },
};
