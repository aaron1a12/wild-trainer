App.Register({
	"id": "PhoneApp",
	"onStart": function(){
		this.workArea = App.GetWorkspace();

		var div = document.createElement("div");
		div.innerHTML = ' \
		Phone App \
		</div>';
		
		this.workArea.appendChild(div);
	},
	/*"onExit": function(){
	}*/
});