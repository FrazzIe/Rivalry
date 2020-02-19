<template>
	<v-flex xs4>
		<v-card class="elevation-12 main-content" tile>
			<v-toolbar dense color="primary" dark flat card height="45">
				<v-toolbar-title>Changelog</v-toolbar-title>
					<v-spacer></v-spacer>

					<v-tooltip right>
						<v-btn flat icon slot="activator" @click="">
							<v-icon>refresh</v-icon>
						</v-btn>
						<span>Refresh</span>
					</v-tooltip>
			</v-toolbar>
		</v-card>
	</v-flex>
</template>

<script>
export default {
	data: () => ({
		listener: null,
	}),
	methods: {
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