<template>
	<v-flex xs8>
		<v-card class="elevation-12 main-content" tile>
			<v-toolbar dense color="primary" dark flat card height="45">
				<v-toolbar-title>Character selection</v-toolbar-title>

					<v-spacer></v-spacer>

					<v-tooltip right>
						<v-btn flat icon slot="activator" @click="">
							<v-icon>add</v-icon>
						</v-btn>
						<span>New character</span>
					</v-tooltip>
			</v-toolbar>

			<v-card-text class="css-content scroll-bar">
				<v-layout row wrap>
					<v-flex xs12 v-for="(item, index) in characters" :key="index">
						<v-card class="elevation-6" color="grey lighten-5">
							<v-card-title>
								<span class="title">{{ item.first_name }} {{ item.last_name }} ({{ calculateAge(item.dob) }})</span>

								<v-spacer></v-spacer>

								<v-tooltip right>
									<v-btn flat small icon color="error" slot="activator" @click="">
										<v-icon>close</v-icon>
									</v-btn>
									<span>Delete character</span>
								</v-tooltip>					
							</v-card-title>

							<v-divider></v-divider>

							<div v-if="item.background">
								<v-card-text class="bg-content">
									{{ item.background }}
								</v-card-text>

								<v-divider></v-divider>
							</div>

							<v-card-actions>
								<v-tooltip right>
									<v-btn color="primary" slot="activator" @click="">Play</v-btn>
									<span>Select character</span>
								</v-tooltip>

								<v-spacer></v-spacer>
								
								<span class="caption">{{ formatDuration(item.timeplayed, "seconds", "h [hours], m [minutes], s [seconds]", { largest: 1 }) }} <span v-if="item.timeplayed != 0">played</span></span>
							</v-card-actions>
						</v-card>
					</v-flex>
				</v-layout>
			</v-card-text>
		</v-card>
	</v-flex>
</template>

<script>
import moment from 'moment';
import momentDuration from 'moment-duration-format';
import marked from 'marked';

export default {
	data: () => ({
		listener: null,
		characters: [
			{ character_id: 1, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
			{ character_id: 2, identifier: "steam:1100001057052a0", first_name: "Danny", last_name: "Phantom", dob: "07/15/1999", timeplayed: 1848985, background: "Is a shit cop who is corrupt as fuck..." },
			{ character_id: 3, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
			{ character_id: 4, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
		],
	}),
	computed: {
		currentDate() {
			return new Date();
		}
	},
	methods: {
		SetCharacters(payload) {
			this.characters = payload;
		},
		calculateAge(dob) {
			var birthDate = new Date(dob);
			var age = this.currentDate.getFullYear() - birthDate.getFullYear();
			var monthRange = this.currentDate.getMonth() - birthDate.getMonth();

			if (monthRange < 0 || (monthRange === 0 && this.currentDate.getDate() < birthDate.getDate())) {
				age--;
			}

			return age;
		},
		formatDuration(time, type, format, args) {
			return moment.duration(time, type).format(format, args);
		},
		md(t) {
			return marked(t);
		}
	},
	mounted() {
		this.listener = window.addEventListener("message", (event) => {
			const item = event.data || event.detail;
			if (this[item.type] != null && item.payload != null) this[item.type](item.payload);
		});
	}	
}
</script>

<style scoped>
	.css-content {
		min-height: 555px;
		max-height: 555px;
		overflow-y: auto;
	}

	.bg-content {
		max-height: 300px;
		overflow-y: auto;
		overflow-x: hidden;
		word-wrap: break-word;
	}

</style>