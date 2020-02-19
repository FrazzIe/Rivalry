<template>
	<v-app v-show="visible">
		<v-content>
			<v-container fluid fill-height grid-list-xl>
				<v-layout align-center justify-center>
					<v-flex xs7 sm10 md10 lg10 xl7>
						<v-layout>
							<Character :deleteEnabled="charRemoval" :characterLimit="charLimit" :resourceName="resourceName"/>
							<Changelog :resourceName="resourceName"/>
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
		charRemoval: false,
		charLimit: 5,
		resourceName: "",
	}),
	methods: {
		SetVisible(payload) {
			this.visible = payload === true;
		},
		EnableCharRemoval(payload) {
			this.charRemoval = payload === true;
		},
		SetCharLimit(payload) {
			if (!isNaN(payload)) { 
				this.charLimit = payload;
			}
		}
	},
	mounted() {
		this.listener = window.addEventListener("message", (event) => {
			const item = event.data || event.detail;
			if (this[item.type] != null && item.payload != null) this[item.type](item.payload);
			//this.resourceName = GetParentResourceName();
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