App.Register({
	"id": "Contacts",
	"onStart": function(){
		this.workArea = App.GetWorkspace();

		var div = document.createElement("div");
		div.innerHTML = `List of players:
		<div id="contactsApp_playerList"></div>
		`;
		
		this.workArea.appendChild(div);
		
		$.post('http://wild-trainer/getPlayers', JSON.stringify({}));
	},
	"onGoBack": function(){
		if(App.Collection[App.Running].currentPage==0) {
			App.Exit();
		}else{
			App.GetWorkspace().innerHTML = "";
			App.ExecuteCmd('onStart');
			App.Collection[App.Running].currentPage = 0;
		}
	},
	"currentPage": 0,
	"currentRecipient": {},
	"messageHistory": {},
	"contactNames": {}
});

function contactsApp_openChat( recipient ) {
	this.workArea = App.GetWorkspace();
	this.workArea.innerHTML = "";
	App.Collection[App.Running].currentPage = 1;
	App.Collection[App.Running].currentRecipient = recipient;

	var div = document.createElement("div");
	div.innerHTML = `
	<div style="display:flex;flex-direction:column;height:100%;background-color:red;">
		<div id="contactsApp_chatArea" style="height:100%; overflow-y:scroll; background-color: #fff;">
		</div>
		<div id="contactsApp_composerArea" style="height:30%; background-color: #ccc;">
			<textArea id="contactsApp_composer" style="width:100%;"></textArea>
			<button onclick="contactsApp_sendTextMessage();">Send</button>
		</div>
	</div>
	`;
	this.workArea.appendChild(div);

	if(App.Collection[App.Running].messageHistory[recipient] == undefined)
		App.Collection[App.Running].messageHistory[recipient] = [];

	contactsApp_restoreMessageHistory();
}

function contactsApp_sendTextMessage() {
	var textArea = document.getElementById("contactsApp_composer");

	var newMessage = {
		"senderName": "You",
		"text": textArea.value
	}; 

	App.Collection["Contacts"].messageHistory[App.Collection[App.Running].currentRecipient].push(newMessage);
	
	contactsApp_drawMessage( newMessage );

	$.post('http://wild-trainer/sendTextMessage', JSON.stringify({
		recipient: App.Collection[App.Running].currentRecipient,
		text: textArea.value
	}));

	textArea.value = "";
}

function contactsApp_drawMessage( msg ) {
	var chatArea = document.getElementById("contactsApp_chatArea");

	var div = document.createElement("div");
	div.innerHTML = `<b><i>${msg.senderName}:</i></b> ${msg.text}`;
	chatArea.appendChild(div);

	chatArea.scrollTop = chatArea.scrollHeight;
}

function contactsApp_restoreMessageHistory() {
	var recipient = App.Collection[App.Running].currentRecipient;
	var messageHistory = App.Collection[App.Running].messageHistory[recipient];
	
	var chatArea = document.getElementById("contactsApp_chatArea");
	chatArea.innerHTML = "";

	for(var i=0; i < messageHistory.length; i++) {
		contactsApp_drawMessage(messageHistory[i]);
	}
}

function contactsApp_receiveMessage(text, sender, senderName) {
	if(App.Collection["Contacts"].messageHistory[sender] == undefined)
		App.Collection["Contacts"].messageHistory[sender] = [];

	var newMessage = {
		"senderName": senderName,
		"text": text
	}; 

	App.Collection["Contacts"].messageHistory[sender].push(newMessage);

	if(App.Running=="Contacts" && App.Collection["Contacts"].currentPage==1)
	{
		contactsApp_drawMessage(newMessage);
	}
	else
	{
		Notification.Show(Notification.Icon.Message, newMessage.senderName, newMessage.text, 4);
	}
}

window.addEventListener('message', function(event) {
	if (typeof event.data.receivePlayers != "undefined") {
		console.log("receiving player list.");
		// event.data.activePlate <-- current spawned car

		var playerList = event.data.players;

		var html = "";
		for(var i=0; i < playerList.length; i++) {
			html += `
			<div style="margin-bottom:20px; border-bottom:1px solid #000;">
				${playerList[i].name} (ID: ${playerList[i].id}) <button onclick="contactsApp_openChat('${playerList[i].id}');">Chat</button><br>
			</div>`;

			App.Collection[App.Running].contactNames[playerList[i].id] = playerList[i].name;
		}
		
		/*for (var player in event.data.players) {
			html += `--${player.name}<br>`;
		}*/
		
		document.getElementById("contactsApp_playerList").innerHTML = html;
	}

	if (typeof event.data.receiveText != "undefined") {
		contactsApp_receiveMessage(event.data.text, event.data.sender, event.data.senderName);
	}
});