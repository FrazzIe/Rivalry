<template>
	<v-app v-show="visible">
		<v-content>
			<v-container fluid fill-height grid-list-xl>
				<v-layout align-center justify-center>
					<v-flex xs7 sm10 md10 lg10 xl7>
						<v-layout>
							<Character/>
							<Changelog/>
						</v-layout>
					</v-flex>
				</v-layout>
			</v-container>
		</v-content>
		<!-- Alerts -->
		<v-snackbar v-model="snack" :color="snackColour" bottom right :timeout="6000">
			{{ snackMsg }}

			<v-btn icon @click="snack = false;">
				<v-icon>close</v-icon>
			</v-btn>
		</v-snackbar>
		<!-- Loader -->
		<v-dialog v-model="loader" persistent :width="300">
			<v-card>
				<v-card-text class="text-xs-center">
					{{ loaderMessage }}
					<v-progress-linear indeterminate color="primary" class="mb-0"></v-progress-linear>
				</v-card-text>
			</v-card>
		</v-dialog>
	</v-app>
</template>

<script>
import { mapState, mapMutations } from 'vuex';
import Character from './components/Character.vue'
import Changelog from './components/Changelog.vue'

export default {
	name: "char-ss",
	components: {
		Character,
		Changelog
	},
	data: () => ({
		listener: null,
		snack: false,
		snackMsg: "",
	}),
	watch: {
		snackMessage(value) {
			if (value !== "") {          
				this.snack = true;
				this.snackMsg = this.snackMessage;
				this.SetSnackMessage("");
			}
		}
	},
	computed: {
		...mapState(["visible", "loader", "loaderMessage", "snackColour", "snackMessage"]),
	},
	methods: {
		...mapMutations(["SetVisible", "EnableCharRemoval", "SetCharLimit", "SetCharacters", "SetChangelog", "SetSnackMessage"]),
	},
	mounted() {
		this.listener = window.addEventListener("message", (event) => {
			const item = event.data || event.detail;
			if (this[item.type] != null && item.payload != null) this[item.type](item.payload);
		});
	}
}    
</script>

<style>
	#app {
		background-color: rgba(0, 0, 0, 0.0);
	}

	.main-content {
		min-height: 600px;
		max-height: 600px;
		height: 100%;
	}
	
	::-webkit-scrollbar { 
		display: none; 
	}

	.scroll-bar::-webkit-scrollbar-track
	{
		-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.1);
		background-color: #F5F5F5;
	}

	.scroll-bar::-webkit-scrollbar
	{
		display: block;
		height: 6px;
		width: 6px;
		background-color: #F5F5F5;
	}

	.scroll-bar::-webkit-scrollbar-thumb
	{
		-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
		background-color: #555;
	}
</style>