<template>
	<v-app>
		<v-content>
			<v-container fluid full-height>
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
	}
}
</script>

<style>
</style>