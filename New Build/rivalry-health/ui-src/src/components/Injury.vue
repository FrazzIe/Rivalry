<template>
  <v-container v-if="visible">
    <v-layout row wrap align-end justify-end>
      <v-flex xs3>
        <v-card>
          <v-layout row wrap>
            <v-flex>
              <div caption class="text-lg-left ml-1">Injury list</div>
            </v-flex>
            <v-flex>
              <div caption class="text-lg-right mr-1">{{ characterName }}</div>
            </v-flex>
          </v-layout>
          <v-expansion-panel v-if="!InjuriesEmpty">
            <v-expansion-panel-content expand-icon="arrow_drop_down" v-for="(rows, bodypart) in injuries" :key="bodypart">
              <div slot="header">{{ bodypart }}</div>
              <v-list dense class="overflow-x-hidden visible-bar" style="max-height: 200px;">
                <v-list-tile v-for="(amount, injury) in rows" :key="injury">
                  <v-list-tile-content>{{ injury }}:</v-list-tile-content>
                  <v-list-tile-action>
                    <v-list-tile-action-text>{{ amount }} HP</v-list-tile-action-text>
                  </v-list-tile-action>
                </v-list-tile>
              </v-list>
            </v-expansion-panel-content>
          </v-expansion-panel>
          <div v-if="InjuriesEmpty">
            <div class="text-lg-center"><v-icon>info</v-icon></div>
            <div caption class="text-lg-center">No injuries found</div>
          </div>
        </v-card>
        <v-btn depressed block color="error" @click="CloseInjuries()">Close</v-btn>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    data: () => ({
      visible: false,
      injuries: {},
      characterName: "",
    }),
    mounted() {
      this.listener = window.addEventListener('message', (event) => {
        const item = event.data || event.detail;
        if (this[item.type] && item.payload) this[item.type](item.payload);
      });
    },
    computed: {
      InjuriesEmpty: function() {
        return Object.keys(this.injuries).length === 0;
      },
    },
    methods: {
      onkeydown(e) {
        let key = e.which;
        if (key == 8 || key == 27) {
          this.CloseInjuries();
        }
      },
      DisplayInjuries(payload) {
        this.visible = true;
        this.injuries = payload.injuries;
        this.characterName = payload.name;
      },
      CloseInjuries() {
        fetch('http://rivalry-health/close',{
          method: 'post',
          body: JSON.stringify({}),
        }).then(() => { this.visible = false; this.injuries = {}; this.characterName = ""; });
      }
    },
    created() {
      document.onkeydown = this.onkeydown;
    }
  }
</script>

<style>
</style>
