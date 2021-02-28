const carNames = {
	police2: "Vapid Cruiser",
	infernus: "Pegassi Infernus",
	jester: "Dinka Jester",
};


App.Register({
	"id": "CarsApp",
	"onStart": function(){
		this.workArea = App.GetWorkspace();
		
		var div = document.createElement("div");
		div.id = "carApp_container";
		div.innerHTML = `
		<div id="carApp_menu">
			<img src="img/app-car.png">
			<div id="carApp_title">
				<span>Owned vehicles</span>
			</div>
		</div>
		<div id="carsOwned">&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;Loading...</div> 
		`;
		
		this.workArea.appendChild(div);


		// BEGIN CHROME DEBUG
		/* 
		receiveGarage({
			data: {
				receiveGarage: "receiveGarage",
				playerGarage: {
					"ABCZ0987": {model: "police2"},
					"INFERN87": {model: "infernus"},
					"FWEZ0988": {model: "jester"},
					"FWEZ0981": {model: "FOO1"},
					"FWEZ0982": {model: "FOO2"},
					"FWEZ0983": {model: "FOO3"}
					
				}
			}
		});
		*/
		// END CHROME DEBUG

		setTimeout(function(){
			$.post('http://wild-trainer/getGarage', '{}');
		},1000)
		
	},
	/*"onExit": function(){
	}*/
});

//var registeredVehicles = [];

function requestVehicle( plateNumber ) {
	$.post('http://wild-trainer/requestVehicle', JSON.stringify({plate:plateNumber}));
	Notification.Show(Notification.Icon.Car, "Premium Deluxe Motorsports", "Delivery requested.", 2);
}


function receiveGarage(event) {
	if (typeof event.data.receiveGarage != "undefined") {
		var html = "";
		for (var plate in event.data.playerGarage) {

			// Only process land vehicles
			if(event.data.playerGarage[plate].type != undefined)
			{
				if (event.data.playerGarage[plate].type != 1)
					continue;
			}

			var carName = event.data.playerGarage[plate].model;

			if(carNames[ event.data.playerGarage[plate].model ]!=undefined) {
				carName = carNames[ event.data.playerGarage[plate].model ];
			}

			//html = html + "<b>"+carName+", plate "+plate+"</b><button onclick=\"requestVehicle('"+plate+"');\">Request delivery</button><br>";

			html += `
			<div class="carApp_item">
				<div>${carName}</div>
				<button onclick="requestVehicle('${plate}');">Request delivery</button>
			</div>`;
		}
		
		var carsOwned = document.getElementById("carsOwned");
		
		if(carsOwned!=undefined)
			carsOwned.innerHTML = html;
	}
}


window.addEventListener('message', function(event) {
	
	receiveGarage(event);
	
	/*if (typeof event.data.receiveGarage != "undefined") {
		// event.data.activePlate <-- current spawned car
		//registeredVehicles.push([event.data.plate, event.data.color, event.data.model])
	}/*else if (event.data.type == "unregisterVehicle"){		
		
		for (var i = 0; i < registeredVehicles.length; i++) {		
			if (event.data.plate == registeredVehicles[i][0]) {
				registeredVehicles.splice(i, 1); 
			}
		}		
	}	*/
});

function Delay() {
	setTimeout(function(){
		Notification.Show(Notification.Icon.MorsMutual, "Mors Mutual Auto Insurance", "Your claim has been denied.", Notification.StandardTimeout);
	},5000);
}