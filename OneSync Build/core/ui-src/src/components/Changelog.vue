<template>
	<v-flex xs4>
		<v-card class="elevation-12 main-content" tile>
			<v-toolbar dense color="primary" dark flat card height="45">
				<v-toolbar-title>Changelog</v-toolbar-title>
					<v-spacer></v-spacer>

					<v-tooltip right>
						<v-btn flat icon slot="activator" :loading="loading" :disabled="loading" @click="refreshChangelog">
							<v-icon>refresh</v-icon>
							<template v-slot:loader>
								<span class="cl-loader">
									<v-icon light>refresh</v-icon>
								</span>
							</template>
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
		loading: false,
	}),
	computed: {
		...mapState(["resourceName", "changelog"]),
	},
	methods: {
		refreshChangelog() {
			this.loading = true;

			fetch("http://" + this.resourceName + "/refresh", {
				method: "post",
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

	.cl-loader {
		animation: loader 1s infinite;
		display: flex;
	}

	@-moz-keyframes loader {
		from {
			transform: rotate(0);
		}
		to {
			transform: rotate(360deg);
		}
	}

	@-webkit-keyframes loader {
		from {
			transform: rotate(0);
		}
		to {
			transform: rotate(360deg);
		}
	}

	@-o-keyframes loader {
		from {
			transform: rotate(0);
		}
		to {
			transform: rotate(360deg);
		}
	}
	
	@keyframes loader {
		from {
			transform: rotate(0);
		}
		to {
			transform: rotate(360deg);
		}
	}
</style>