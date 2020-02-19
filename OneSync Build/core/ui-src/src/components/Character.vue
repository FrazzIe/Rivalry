<template>
	<v-flex xs8>
		<v-card class="elevation-12 main-content" tile>
			<v-toolbar dense color="primary" dark flat card height="45">
				<v-toolbar-title>Character selection</v-toolbar-title>

					<v-spacer></v-spacer>

					<div v-if="characters.length < characterLimit">
						<v-tooltip right>
							<v-btn flat icon slot="activator" @click="createDialog = true">
								<v-icon>add</v-icon>
							</v-btn>
							<span>New character</span>
						</v-tooltip>
					</div>
			</v-toolbar>

			<v-card-text class="css-content scroll-bar">
				<v-layout row wrap>
					<v-flex xs12 v-for="(item, index) in characters" :key="index">
						<v-card class="elevation-6" color="grey lighten-5">
							<v-card-title>
								<span class="title">{{ item.first_name }} {{ item.last_name }} ({{ calculateAge(item.dob) }})</span>

								<v-spacer></v-spacer>

								<div v-if="deleteEnabled">
									<v-tooltip right>
										<v-btn flat small icon color="error" slot="activator" @click="openDeleteDialog(index, item)">
											<v-icon>close</v-icon>
										</v-btn>
										<span>Delete character</span>
									</v-tooltip>
								</div>
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
									<v-btn color="primary" slot="activator" @click="selectCharacter(item.character_id)">Play</v-btn>
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

		<v-dialog v-model="deleteDialog" width="350">
			<v-card flat tile>
				<v-toolbar dense color="primary" dark flat card>
					<v-toolbar-title>Delete character</v-toolbar-title>
				</v-toolbar>

				<v-card-text>
					Are you sure you want to delete {{ currentChar.first_name }} {{ currentChar.last_name }}?
				</v-card-text>

				<v-divider></v-divider>

				<v-card-actions>
					<v-btn color="primary darken-1" flat @click="deleteCharacter()">Yes</v-btn>
					<v-btn color="primary darken-1" flat @click="deleteDialog = false">No</v-btn>
				</v-card-actions>
			</v-card>
		</v-dialog>

		<v-dialog v-model="createDialog" width="600">
			<v-card flat tile>
				<v-toolbar dense color="primary" dark flat card>
					<v-toolbar-title>New character</v-toolbar-title>
				</v-toolbar>

				<v-stepper v-model="characterStepper">
					<v-stepper-header>
						<v-stepper-step :complete="characterStepper > 1" step="1" :rules="[() => !errors.has('charForm1.firstName') && !errors.has('charForm1.lastName') && !errors.has('charForm1.sex') && !errors.has('charForm1.dob')]">
							Basic Details
						</v-stepper-step>

						<v-divider></v-divider>

						<v-stepper-step :complete="characterStepper > 2" step="2" :rules="[() => !errors.has('charForm2.background')]">
							Background
						</v-stepper-step>
					</v-stepper-header>

					<v-stepper-content step="1">
						<v-form data-vv-scope="charForm1" @submit.prevent="createCharacter('charForm1')">
							<v-text-field v-model="firstName" label="First name" data-vv-name="firstName" data-vv-as="First name" v-validate="{ required: true, regex: /^[a-z,'-]+$/i, min: 3, max: 21 }" :error-messages="errors.collect('charForm1.firstName')"></v-text-field>

							<v-text-field v-model="lastName" label="Last name" data-vv-name="lastName" data-vv-as="Last name" v-validate="{ required: true, regex: /^[a-z,'-]+$/i, min: 3, max: 21 }" :error-messages="errors.collect('charForm1.lastName')"></v-text-field>

							<v-select v-model="sex" label="Sex" :items="sexItems" item-text="state" item-value="value" data-vv-name="sex" data-vv-as="Sex" v-validate="{ required: true }" :error-messages="errors.collect('charForm1.sex')"></v-select>

							<v-menu ref="birthdayMenu" v-model="birthdayMenu" :close-on-content-click="false" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
								<v-text-field v-model="formattedDate" label="Date of birth" readonly slot="activator" data-vv-name="dob" data-vv-as="Date of birth" v-validate="{ required: true }" :error-messages="errors.collect('charForm1.dob')"></v-text-field>
								<v-date-picker ref="birthdayPicker" v-model="birthDate" :max="new Date().toISOString().substr(0, 10)" min="1950-01-01" @change="saveBirthdate"></v-date-picker>
							</v-menu>

							<v-btn color="primary" type="submit">
								Continue
							</v-btn>

							<v-btn flat @click="createDialog = false">Cancel</v-btn>
						</v-form>
					</v-stepper-content>

					<v-stepper-content step="2">
						<v-form data-vv-scope="charForm2" @submit.prevent="createCharacter('charForm2')">
							<v-textarea  v-model="background" label="Tell us about the character you will be playing and what makes it unique" prepend-icon="create" counter no-resize rows="12" data-vv-name="background" data-vv-as="Background" v-validate="{ required: true, min: 50, max: 900 }" :error-messages="errors.collect('charForm2.background')"></v-textarea>

							<v-btn color="primary" type="submit">
								Continue
							</v-btn>

							<v-btn flat @click="characterStepper = 1">Back</v-btn>

							<v-btn flat @click="createDialog = false">Cancel</v-btn>
						</v-form>
					</v-stepper-content>
				</v-stepper>
			</v-card>
		</v-dialog>
	</v-flex>
</template>

<script>
import moment from 'moment';
import momentDuration from 'moment-duration-format';
import marked from 'marked';

export default {
	data: () => ({
		resourceName: "",
		listener: null,
		characters: [
			{ character_id: 1, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
			{ character_id: 2, identifier: "steam:1100001057052a0", first_name: "Danny", last_name: "Phantom", dob: "07/15/1999", timeplayed: 1848985, background: "Is a shit cop who is corrupt as fuck..." },
			{ character_id: 3, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
			{ character_id: 4, identifier: "steam:1100001057052a0", first_name: "Shin", last_name: "Wolford", dob: "07/15/1999", timeplayed: 1848985 },
		],
		deleteDialog: false,
		currentCharIdx: null,
		currentChar: {},
		createDialog: false,
		characterStepper: 0,
		sexItems: [
			{ state: "Male", value: 0 },
			{ state: "Female", value: 1 },
		],
		firstName: "",
		lastName: "",
		sex: { state: "Male", value: 0 },
		birthdayMenu: false,
		birthDate: null,
		background: "",
	}),
	props: {
		deleteEnabled: Boolean,
		characterLimit: Number,
	},
	computed: {
		currentDate() {
			return new Date();
		},
		formattedDate(date) {
			return this.formatDate(this.birthDate);
		}
	},
	methods: {
		SetCharacters(payload) {
			this.characters = payload;
		},
		selectCharacter(id) {
			fetch("http://" + this.resourceName + "/select", {
				method: "post",
				body: JSON.stringify(id),
			}).catch((error) => {
				console.log(error);
			});
		},
		deleteCharacter() {
			this.deleteDialog = false;
			this.characters.splice(this.currentCharIdx, 1);
			fetch("http://" + this.resourceName + "/delete", {
				method: "post",
				body: JSON.stringify(this.currentChar.character_id),
			}).catch((error) => {
				console.log(error);
			});
		},
		openDeleteDialog(idx, item) {
			this.deleteDialog = true;
			this.currentCharIndex = idx;
			this.currentChar = item;
		},
		createCharacter(scope) {
			this.$validator.validateAll(scope).then((valid) => {
				if (valid) {
					if (this.characterStepper != 2) {
						this.characterStepper++;
					} else {
						this.createDialog = false;
						this.characterStepper = 1;

						fetch("http://rivalry-selection/create", {
							method: "post",
							body: JSON.stringify({
								firstName: this.firstName,
								lastName: this.lastName,
								sex: this.sex.value,
								birthDate: this.formattedDate,
								background: this.background,
							})
						}).then((resp) => {
							this.firstName = "";
							this.lastName = "";
							this.sex = { state: "Male", value: 0 };
							this.birthDate = null;
							this.background = "";
						}).catch((error) => {
							console.log(error);
						});
					}
				}
			});
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
		},
		saveBirthdate(date) {
			this.$refs.birthdayMenu.save(date);
		},
		formatDate(date) {
			if (!date) return null;

			const [year, month, day] = date.split('-');
			return `${month}/${day}/${year}`;
		}
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