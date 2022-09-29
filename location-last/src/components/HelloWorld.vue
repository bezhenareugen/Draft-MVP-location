<template>
  <div style="height: 500px; width: 100%">
    <div style="height: 200px; overflow: auto;">
      <p>First marker is placed at </p>
      <p>Center is at {{ currentCenter }} and the zoom is: {{ currentZoom }}</p>
      <button @click="showLongText">
        Toggle long popup
      </button>
      <button @click="showMap = !showMap">
        Toggle map
      </button>
    </div>
    <l-map
        v-if="showMap"
        :zoom="zoom"
        :center="center"
        :options="mapOptions"
        style="height: 80%"
        @update:center="centerUpdate"
        @update:zoom="zoomUpdate"
    >
      <l-tile-layer
          :url="url"
          :attribution="attribution"
      />
      <l-marker :lat-lng="withTooltip" :icon="icon">
        <l-tooltip :options="{ permanent: false, interactive: true }">
          <div @click="innerClick">
            I am a tooltip
            <p v-show="showParagraph">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque
              sed pretium nisl, ut sagittis sapien. Sed vel sollicitudin nisi.
              Donec finibus semper metus id malesuada.
            </p>
          </div>
        </l-tooltip>
      </l-marker>
    </l-map>
  </div>
</template>

<script>
import { latLng, icon } from "leaflet";
import { LMap, LTileLayer, LMarker, LTooltip } from "vue2-leaflet";
import {HubConnectionBuilder} from "@microsoft/signalr";

export default {
  name: "HelloWorld",
  components: {
    LMap,
    LTileLayer,
    LMarker,
    LTooltip
  },
  data() {
    return {
      x: 1,
      y: 2,
      icon: icon({
        iconUrl: require('../assets/car.png'),
        iconSize: [32, 37],
        iconAnchor: [16, 37]
      }),
      zoom: 13,
      center: latLng(this.x, this.y),
      url: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attribution:
          '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      withTooltip: latLng(20, 30),
      currentZoom: 11.5,
      currentCenter: latLng(this.x, -1.219482),
      showParagraph: false,
      mapOptions: {
        zoomSnap: 0.5
      },
      showMap: true
    };
  },
  created() {
    const connection = new HubConnectionBuilder()
        .withUrl('http://api.app.roofest.online/chat')
        .build();

    connection.start();

    connection.on("ReceiveMessage", (data) => {
      console.log("Received Location From App");
      console.log(data);
      // this.lat = data.lat;
      // this.lng = data.lng;
      this.center = latLng(data.lat, data.lng);
      this.withTooltip = latLng(data.lat, data.lng);
    });
  },
  methods: {
    zoomUpdate(zoom) {
      this.currentZoom = zoom;
    },
    centerUpdate(center) {
      this.currentCenter = center;
    },
    showLongText() {
      this.showParagraph = !this.showParagraph;
    },
    innerClick() {
      alert("Click!");
    }
  }
};
</script>
