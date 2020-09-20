import Vue from 'vue'

import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";

import App from '../pages/admin/admin.vue'

Vue.use(Vuetify);
const vuetify = new Vuetify();


document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    vuetify,
    icons: {
      iconfont: "mdi",
    },
    render: h => h(App)
  })

  console.log(app)
})
