<template>
	<v-flex xs4>
		<v-card class="elevation-12 css-content" tile>
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
	
}
</script>

<style>

</style>