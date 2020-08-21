import Vue from 'vue'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import '@mdi/font/css/materialdesignicons.css'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../pages/app.vue'

Vue.use(Vuetify);
const vuetify = new Vuetify();


document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    vuetify,
    render: h => h(App)
  })

  console.log(app)
})
