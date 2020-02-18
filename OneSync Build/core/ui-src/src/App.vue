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
	</v-app>
</template>

<script>
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
		visible: true,
	}),
	methods: {
		SetVisible(payload) {
			this.visible = payload === true;
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
	.css-content {
		min-height: 600px;
		max-height: 600px;
		height: 100%;
	}
</style>