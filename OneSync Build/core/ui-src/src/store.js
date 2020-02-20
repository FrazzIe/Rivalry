import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    visible: true,
    resourceName: "",
    charRemoval: false,
    charLimit: 5,
		characters: [
			{ character_id: 1, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
			{ character_id: 2, identifier: "steam:1100001057052a0", first_name: "Danny", last_name: "Phantom", dob: "07/15/1999", timeplayed: 1848985, background: "Is a shit cop who is corrupt as fuck..." },
			{ character_id: 3, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
			{ character_id: 4, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
    ],
    changelog: "# Beep boop beep",
    loader: false,
    loaderMessage: "Loading..",
    snackColour: "error",
    snackMessage: "",
  },
  mutations: {
		SetVisible(_, payload) {
			this.state.visible = payload === true;
		},
		EnableCharRemoval(_, payload) {
			this.state.charRemoval = payload === true;
		},
		SetCharLimit(_, payload) {
			if (!isNaN(payload)) { 
				this.state.charLimit = payload;
			}
    },
		SetCharacters(_, payload) {
			this.state.characters = payload;
    },
		SetChangelog(_, payload) {
			this.state.changelog = payload;
    },
    ShowLoader(_, value) {
      this.state.loader = value;
    },
    SetLoaderMessage(_, value) {
      this.state.loaderMessage = value;
    },
    SetSnackColour(_, value) {
      switch(value) {
        case "success":
        case "info":
        case "warning":
        case "error":
            this.state.snackColour = value;
          break;
        default:
            this.state.snackColour = "info";
          break;
      }
    },
    SetSnackMessage(_, value) {
      this.state.snackMessage = value;
    },
  },
  actions: {

  },
})