<template>
  <v-app>
    <v-content>
      <Injury/>
    </v-content>
  </v-app>
</template>

<script>
import Injury from './components/Injury'

export default {
  name: 'App',
  components: {
    Injury
  },
  data () {
    return {
      //
    }
  }
}
</script>

<style>
.visible-bar::-webkit-scrollbar-track
{
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
  background-color: #F5F5F5;
}

.visible-bar::-webkit-scrollbar
{
  width: 6px;
  background-color: #F5F5F5;
}

.visible-bar::-webkit-scrollbar-thumb
{
  background-color: gray;
}

.invisible-bar::-webkit-scrollbar-track
{
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
  background-color: #F5F5F5;
}

.invisible-bar::-webkit-scrollbar
{
  width: 6px;
  background-color: #F5F5F5;
  display: none;
}

.invisible-bar::-webkit-scrollbar-thumb
{
  background-color: gray;
}

#app {
  background-color: rgba(0, 0, 0, 0.0);
}
</style>
