App.Register({
	"id": "WeazelNews",
	"onStart": function(){
		this.workArea = App.GetWorkspace();

		var div = document.createElement("div");
		div.innerHTML = ' \
		No news available.';
		
		this.workArea.appendChild(div);
		
		console.log("Tell FIVEM to start the mission!");
		$.post('http://wild-trainer/lua_startNukeMission', JSON.stringify({}));
	},
	/*"onExit": function(){
	}*/
});