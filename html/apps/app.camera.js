App.Register({
	"id": "CameraApp",
	"onStart": function(){
		this.workArea = App.GetWorkspace();

		var div = document.createElement("div");
		div.innerHTML = ' \
		Loading camera... \
		</div>';
		
		this.workArea.appendChild(div);
		
		setTimeout(closePhone, 1);
		$.post('http://wild-trainer/lua_openCamera', JSON.stringify({}));
		
	},
	/*"onExit": function(){
	}*/
});