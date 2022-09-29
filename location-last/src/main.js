import Vue from 'vue'
import App from './App.vue'
import 'leaflet/dist/leaflet.css';
import signalR from "@/plugins/signalR";

Vue.config.productionTip = false;
Vue.use(signalR);

new Vue({
  render: h => h(App),
}).$mount('#app')

