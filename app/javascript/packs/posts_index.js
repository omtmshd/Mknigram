import Vue from 'vue'
import PostsIndex from '../components/PostsIndex.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('post'))
  const app = new Vue({
    el,
    render: h => h(PostsIndex)
  })

  console.log(app)
})


