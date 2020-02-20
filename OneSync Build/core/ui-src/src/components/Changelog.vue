<template>
	<v-flex xs4>
		<v-card class="elevation-12 main-content" tile>
			<v-toolbar dense color="primary" dark flat card height="45">
				<v-toolbar-title>Changelog</v-toolbar-title>
					<v-spacer></v-spacer>

					<v-tooltip right>
						<v-btn flat icon slot="activator" :loading="loader" :disabled="loader" @click="refreshChangelog">
							<v-icon>refresh</v-icon>
						</v-btn>
						<span>Refresh</span>
					</v-tooltip>
			</v-toolbar>

			<v-card-text class="cl-content scroll-bar" v-html="md(changelog)">
			</v-card-text>
		</v-card>
	</v-flex>
</template>

<script>
import { mapState, mapMutations } from 'vuex';
import marked from 'marked';
export default {
	data: () => ({
		listener: null,
	}),
	computed: {
		...mapState(["resourceName", "changelog", "loader"]),
	},
	methods: {
		...mapMutations(["ShowLoader", "SetLoaderMessage", "SetSnackColour", "SetSnackMessage"]),
		refreshChangelog() {
			this.SetLoaderMessage("Fetching latest changelog...");
			this.ShowLoader(true);

			let self = this;

			fetch("http://" + this.resourceName + "/refresh", {
				method: "post",
			}).then((resp) => {
				return resp.json();
			}).then((data) => {
				self.ShowLoader(false);
				self.SetSnackColour("success");
				self.SetSnackMessage("Changelog refreshed!");
			}).catch((error) => {
				console.log(error);
			});
		},
		md(t) {
			return marked(t);
		},
	},
}
</script>

<style scoped>
	.cl-content {
		min-height: 555px;
		max-height: 555px;
		overflow-y: auto;
	}
</style>