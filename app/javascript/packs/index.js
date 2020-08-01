import Vue from 'vue'
import LikeButton from '../components/Like/LikeButton.vue'

// HTMLが解釈された時点で発生するイベント
document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#like',
    components: { LikeButton }
  })
})
