import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

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
    axios
      .get(`/api/v1/users/current.json`)
      .then((response) => (this.currentUser = response.data));
  },
};
