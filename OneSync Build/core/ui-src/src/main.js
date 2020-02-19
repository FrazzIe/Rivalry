import Vue from 'vue';
import Vuetify from 'vuetify';
import App from './App.vue';
import 'material-design-icons-iconfont/dist/material-design-icons.css';
import 'roboto-fontface/css/roboto/roboto-fontface.css';
import 'vuetify/dist/vuetify.min.css';

Vue.use(Vuetify);

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')
