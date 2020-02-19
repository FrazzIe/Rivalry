<template>
	<v-flex xs4>
		<v-card class="elevation-12 main-content" tile>
			<v-toolbar dense color="primary" dark flat card height="45">
				<v-toolbar-title>Changelog</v-toolbar-title>
					<v-spacer></v-spacer>

					<v-tooltip right>
						<v-btn flat icon slot="activator" @click="refreshChangelog">
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
import marked from 'marked';
export default {
	data: () => ({
		listener: null,
		changelog: "# Beep boop beep",
	}),
	props: {
		resourceName: String,
	},
	methods: {
		SetChangelog(payload) {
			this.changelog = payload;
		},
		refreshChangelog() {
			fetch("http://" + this.resourceName + "/refresh", {
				method: "post",
			}).catch((error) => {
				console.log(error);
			});
		}
		md(t) {
			return marked(t);
		},
	},
	mounted() {
		this.listener = window.addEventListener("message", (event) => {
			const item = event.data || event.detail;
			if (this[item.type] != null && item.payload != null) this[item.type](item.payload);
		});
		//this.resourceName = GetParentResourceName();
	}	
}
</script>

<style scoped>
	.cl-content {
		min-height: 555px;
		max-height: 555px;
		overflow-y: auto;
	}
</style>