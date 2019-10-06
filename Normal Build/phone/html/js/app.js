var app = angular.module('app', []);

app.controller('ctrl', function($scope, $timeout, $http) {	
	// Scroll Bar needs to be fixed...
	$(function() {
		$(".contacts-wrapper, .conversation-wrapper, .call-wrapper, .twitter-wrapper, .messages-wrapper").niceScroll({
			cursorcolor: "#FFFFFF",
			cursorborder: "0px solid #fff",
			cursoropacitymax: 0.1,
			cursorwidth: "3px"
		});
	});

	$scope.resoureName = 'phone';

	$scope.myNumber = '2093533313';

	$scope.convoNumber = '';
	$scope.convoName = '';

	$scope.callInput = '';
	$scope.callStatus = '';
	$scope.isAcceptVisible = false;

	$scope.contactId = null;

	$scope.screenSize = 'medium';

	$scope.dialSound = new Audio('./snd/beepboop.ogg');

	// set views to false
	$scope.phoneToggle = false;
	$scope.callToggle = false;
	$scope.contactsToggle = false;
	$scope.messagesToggle = false;
	$scope.servicesToggle = false;
	$scope.settingsToggle = false;
	$scope.newMessageToggle = false;
	$scope.addContactToggle = false;
	$scope.lifeAlertToggle = false;
	$scope.twitterToggle = false;
	$scope.sendTweetToggle = false;
	$scope.yellowPageToggle = false;
	$scope.sendAdvertisementToggle = false;
	$scope.serviceMessageToggle = false;
	$scope.loadingToggle = false;
	$scope.confirmationToggle = false;
	$scope.error = false;

	$scope.errorMessage = "There has been an error!";

	// Mock Contacts
	$scope.contacts = [
		{
			id: 100,
			character_id: 100,
			phone_number: "2093422054",
			contact_number: "2093422052",
			first_name: "Peter",
			last_name: "Bishop",
		},
		{
			id: 101,
			character_id: 101,
			phone_number: "2093422040",
			contact_number: "2093422051",
			first_name: "Maya",
			last_name: "Hansen",
		}
	]

	//Mock messages
	$scope.messages = [
		{
			contact_name: "Frazzle",
			message: "Sup dood",
			receiver_number: "2091112222"
		},
		{
			message: "Sup dood",
			receiver_number: "2091111111"
		}
	]

	// Mock Convo
	$scope.conversation = [
		{
			id: 100,
			message: "Sup dood",
			creator: "2093533313",
			timestamp: "13383838383"      
		},
		{
			id: 101,
			message: "Sup dood",
			creator: "2093533312",
			timestamp: "13383855383"        
		}
	];

	$scope.twittermessages = [];

	$scope.advertisements = [];

	$scope.taxiOption = '1 passenger';
	$scope.mechOption = 'Car';
	$scope.otherOption = "Weed";

	// Pass Views through this function to toggle
	$scope.toggleView = function(val, contact) {
		//toggle call
		if (val == 'call') {
			if ($scope.callStatus == '') {
				$scope.phoneCallActiveToggle = false;
				$scope.callToggle = !$scope.callToggle;
			} else {
				$scope.callToggle = false;
				$scope.phoneCallActiveToggle = !$scope.phoneCallActiveToggle;
			}
		}
		// toggle contacts
		if (val == 'contacts') {
			$scope.contactsToggle = !$scope.contactsToggle;
		}
		// toggle messages
		if (val == 'messages') {
			$scope.messagesToggle = !$scope.messagesToggle;
		}
		// toggle services
		if (val == 'services') {
			$scope.servicesToggle = !$scope.servicesToggle;
		}
		// toggle other services
		if (val == 'settings') {
			$scope.settingsToggle = !$scope.settingsToggle;
		}
		// toggle calling
		if (val == 'calling') {
			$scope.callingName = contact;
			$scope.contactsToggle = false;
			$scope.callToggle = false;
			$scope.phoneCallActiveToggle = !$scope.phoneCallActiveToggle;
		}
		// toggle text message
		if (val == 'textMessage') {
			$scope.servicesToggle = false;
			$scope.callingName = contact;
			$scope.contactsToggle = false;
			$scope.textMessageToggle = !$scope.textMessageToggle;
		}
		// toggle add contact
		if (val == 'addContact') {
			$scope.contactsToggle = false;
			$scope.callToggle = false;
			$scope.addContactToggle = !$scope.addContactToggle;
		}
		if (val == 'newMessage') {
			$scope.messagesToggle = false;
			$scope.newMessageToggle = !$scope.newMessageToggle;
		}
		if (val == 'twitter') {
			$scope.twitterToggle = !$scope.twitterToggle;
		}
		if (val == 'sendTweet') {
			$scope.sendTweetToggle = !$scope.sendTweetToggle;
			$scope.twitterToggle = true;
		}
		if (val == "sendAdvertisement") {
			$scope.sendAdvertisementToggle = !$scope.sendAdvertisementToggle;
			$scope.yellowPageToggle = true;
		}
		if ( val == "yellowpages") {
			$scope.yellowPageToggle = !$scope.yellowPageToggle;
		}
		if (val == 'lifeAlert') {
			$scope.lifeAlertToggle = !$scope.lifeAlertToggle;
		}
		if (val == 'serviceMessage') {
			$scope.serviceName = contact;
			$scope.servicesToggle = false;
			$scope.serviceMessageToggle = !$scope.serviceMessageToggle;
		}			
		if (val == 'loading') {
			$scope.loadingToggle = !$scope.loadingToggle;
		}

		if (val == "confirmation") {
			$scope.confirmationToggle = !$scope.confirmationToggle;
			$scope.contactId = contact;
		}
		
		if (val == "error") {
			$scope.error = !$scope.error;
			$timeout(function() {
				$scope.error = !$scope.error;
			}, 3000);
		}
	};

	$scope.isAnyViewActive = function() {
		return $scope.callToggle || $scope.contactsToggle || $scope.messagesToggle || $scope.servicesToggle || $scope.settingsToggle || $scope.newMessageToggle || $scope.addContactToggle || $scope.lifeAlertToggle || $scope.twitterToggle || $scope.sendTweetToggle || $scope.yellowPageToggle || $scope.sendAdvertisementToggle || $scope.serviceMessageToggle || $scope.loadingToggle || $scope.confirmationToggle
	};

	$scope.isAnyInputViewActive = function() {
		return $scope.newMessageToggle || $scope.addContactToggle || $scope.sendTweetToggle || $scope.sendAdvertisementToggle || $scope.serviceMessageToggle || $scope.textMessageToggle || $scope.callToggle
	};

	$scope.addDialer = function(val) {
		$scope.dialSound.play();
		switch (val) {
			case "1":
			case "2":
			case "3":
			case "4":
			case "5":
			case "6":
			case "7":
			case "8":
			case "9":
			case "0":
				if ($scope.callInput != null && $scope.callInput != undefined) {
						if ($scope.callInput.length < 10)
							$scope.callInput += val;
				} else {
					$scope.callInput = val;
				}					
				break;
			default:
				break;
		}
	};

	$scope.formatMessageTime = function(val) {
		return moment(val * 1000).fromNow();
	};

	$scope.events = {
		togglePhone(payload) { //Toggle phone visibility
			$scope.lifeAlertToggle = false;
			$scope.phoneToggle = payload === "true";
		},
		toggleLifeAlert(payload) { //Toggle lifealert
			$scope.phoneToggle = true;
			$scope.lifeAlertToggle = payload === "true";
		},
		toggleAnswerBtn(payload) { //Toggle visibility of call answer button
			$scope.isAcceptVisible = payload === "true";

			if (payload === "true") {
				$scope.phoneCallActiveToggle = true;
			}
		},
		setNumber(payload) { //Set phone number
			$scope.myNumber = payload;
		},
		setContacts(payload) { //Set contacts
			$scope.contacts = payload;
		},
		setMessages(payload) { //Set messages
			$scope.messages = payload;
		},
		setConversation(payload) { //Set conversation
			$scope.conversation = payload;
		},
		setCallStatus(payload) { //Set status of call
			$scope.callStatus = payload;

			if ($scope.callToggle) {
				$scope.callToggle = false;
				$scope.phoneCallActiveToggle = true;
			}
		},
		setTwitter(payload) {
			$scope.twittermessages.unshift(payload);
		},
		setYellowpages(payload) {
			$scope.advertisements = payload;
		},
		setCaller(payload) {
			$scope.callingName = payload;
		},
		endCall(payload) {
			if (payload === "true") {
				$scope.phoneCallActiveToggle = false;
				$scope.callingName = "";
				$scope.callStatus = "";
			}
		},
		loadSettings(payload) {
			if (payload.size) {
				$scope.screenSize = payload.size;
			}
		}
	};

	$scope.addContact = function(first, last, number) {
		$scope.loadingToggle = true;
		$scope.addContactToggle = false;

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/addContact",
			data: angular.toJson({first_name: first, last_name: last, contact_number: number})
		}).then(function success(resp) {
			$scope.loadingToggle = false;
			$scope.contactsToggle = true;
		}, function error(resp) {
			$scope.loadingToggle = false;
			$scope.contactsToggle = true;
			console.log(resp);
		});
	};
	
	$scope.removeContact = function(id) {
		$scope.confirmationToggle = false;
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/removeContact",
			data: angular.toJson(id)
		}).then(function success(resp) {
			if(resp.data && resp.data.type) {
				if ($scope.events[resp.data.type] && resp.data.payload) 
					$scope.events[resp.data.type](resp.data.payload);
			}
		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.newMessage = function(number, message) {
		$scope.loadingToggle = true;
		$scope.newMessageToggle = false;

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/newMessage",
			data: angular.toJson({phone_number: number, message: message})
		}).then(function success(resp) {
			$scope.message = "";
			
			if (resp.data && resp.data.error) {
				$scope.errorMessage = resp.data.error;
				$scope.toggleView('error');
			}

			$scope.loadingToggle = false;
			$scope.messagesToggle = true;			
		}, function error(resp) {
			$scope.loadingToggle = false;
			$scope.messagesToggle = true;
			console.log(resp);
		});
	};

	$scope.addMessage = function(message) {
		$scope.loadingToggle = true;
		$scope.textMessageToggle = false;

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/addMessage",
			data: angular.toJson({phone_number: $scope.convoNumber, message: message})
		}).then(function success(resp) {
			$scope.message = "";
			$scope.loadingToggle = false;

			if (resp.data && resp.data.error) {
				$scope.messagesToggle = true;
				$scope.errorMessage = resp.data.error;
				$scope.toggleView('error');
			} else {
				$scope.textMessageToggle = true;
			}
		}, function error(resp) {
			$scope.loadingToggle = false;
			$scope.messagesToggle = true;
			console.log(resp);
		});
	};

	$scope.viewMessages = function(number, name) {
		$scope.loadingToggle = true;
		$scope.contactsToggle = false;
		$scope.messagesToggle = false;
		$scope.convoNumber = number;

		if (name != null) {
			$scope.convoName = name;
		} else {
			$scope.convoName = '';
		}

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/getConversation",
			data: angular.toJson(number)
		}).then(function success(resp) {
			$scope.loadingToggle = false;
			$scope.textMessageToggle = true;
		}, function error(resp) {
			$scope.loadingToggle = false;
			$scope.messagesToggle = true;
			console.log(resp);
		});
	};

	$scope.sendTweet = function(message) {
		$scope.sendTweetToggle = false;
		
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/sendTweet",
			data: angular.toJson({message})
		}).then(function success(resp) {
			$scope.message = "";
			
			if (resp.data && resp.data.error) {
				$scope.errorMessage = resp.data.error;
				$scope.toggleView('error');
			}

			$scope.twitterToggle = true;			
		}, function error(resp) {
			$scope.twitterToggle = true;
			console.log(resp);
		});
	};

	$scope.sendAdvertisement = function(titl, messag) {
		$scope.sendAdvertisementToggle = false;
		
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/sendAdvertisement",
			data: angular.toJson({title: titl, message: messag})
		}).then(function success(resp) {
			$scope.message = "";
			
			if (resp.data && resp.data.error) {
				$scope.errorMessage = resp.data.error;
				$scope.toggleView('error');
			}

			$scope.yellowPageToggle = true;			
		}, function error(resp) {
			$scope.yellowPageToggle = true;
			console.log(resp);
		});
	};

	//LifeAlert requests
	$scope.requestAmbulance = function() {

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/requestAmbulance"
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.requestRespawn = function() {
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/requestRespawn"
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});
	};

	//Service requests
	$scope.requestTrader = function() {
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/request" + $scope.otherOption
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.cancelTrader = function() {
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/cancel" + $scope.otherOption
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.requestService = function(serviceName, value) {
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/request" + serviceName,
			data: angular.toJson(encodeURI(value).replace("%20", " "))
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});	
	};

	$scope.cancelService = function(serviceName) {
		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/cancel" + serviceName
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.call = function(val, number, name) {
		$scope.isAcceptVisible = false;

		switch(val) {
			case "start":
				$scope.callStatus = "Dialing...";
				$scope.callingName = name || number;
				$scope.callToggle = false;
				$scope.contactsToggle = false;
				$scope.phoneCallActiveToggle = true;
				break;
			case "end":
				$scope.phoneCallActiveToggle = false;
				$scope.callingName = "";
				$scope.callStatus = "";
				break;
			case "answer":
				$scope.callStatus = "Active";
				break;
		};

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/" + val + "Call",
			data: angular.toJson(number)
		}).then(function success(resp) {

		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.saveSettings = function() {
		var saveData = { size:  $scope.screenSize };

		$http({
			method: "POST",
			url: "http://" + $scope.resoureName + "/saveSettings",
			data: angular.toJson(saveData)
		}).then(function success(resp) {
			$scope.errorMessage = "Settings saved!";
			$scope.toggleView('error');
		}, function error(resp) {
			console.log(resp);
		});
	};

	$scope.msgListener = window.addEventListener("message", (event) => {
		const item = event.data || event.detail;
		if ($scope.events[item.type] && item.payload) $scope.$apply($scope.events[item.type](item.payload));
	});

	$scope.keyListener = document.addEventListener("keydown", (event) => {
		const key = event.which;

		switch(key) {
			case 27:
			case 113:
				$scope.phoneToggle = false;
				
				$http({
					method: "POST",
					url: "http://" + $scope.resoureName + "/close"
				}).then(function success(resp) {

				}, function error(resp) {
					console.log(resp);
				});
				break;
			case 8:
				if (!$scope.isAnyInputViewActive) {
					$scope.phoneToggle = false;
					
					$http({
						method: "POST",
						url: "http://" + $scope.resoureName + "/close"
					}).then(function success(resp) {

					}, function error(resp) {
						console.log(resp);
					});
				}
				break;
			case 9:
				event.preventDefault();
			default:
				break;
		};
	});
});