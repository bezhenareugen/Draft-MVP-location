import Vue from "vue";
import {HubConnectionBuilder} from "@microsoft/signalr";

const connection = new HubConnectionBuilder()
    .withUrl('http://api.app.roofest.online/chat')
    .build();

new Vue({
    created() {
        connection.start();
    },
});

export default {
    install: function (Vue) {
        Vue.prototype.$signalR = connection;
    },
};
