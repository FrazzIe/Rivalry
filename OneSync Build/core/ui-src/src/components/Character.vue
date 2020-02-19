<template>
	<v-flex xs8>
		<v-card class="elevation-12 css-content" tile>
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

<style>

</style>