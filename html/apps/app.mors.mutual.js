App.Register({
	"id": "MorsMutualApp",
	"onStart": function(){
		this.workArea = App.GetWorkspace();

		var div = document.createElement("div");
		div.innerHTML = `
		<div id="insuranceApp_container"><br><br><br><br><br>
			<img src="img/app-mors-mutual.png">
			<br><br>
			<span style="color:white;">Mors Mutual Auto Insurance</span><br><br>

			<button onclick="Delay();">FILE YOUR CLAIM</button>
		</div>
		`;
		
		this.workArea.appendChild(div);
	},
	/*"onExit": function(){
	}*/
});

function Delay() {
	Notification.Show(Notification.Icon.MorsMutual, "Mors Mutual Auto Insurance", "You filed a claim.", 2);
	setTimeout(function(){
		Notification.Show(Notification.Icon.MorsMutual, "Mors Mutual Auto Insurance", "Your claim has been denied.", Notification.StandardTimeout);
	},5000);
}