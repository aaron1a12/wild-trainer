console.log("Attempting to fetchy!");
		fetch('foo.txt').then(function (response) { //fetch('nui://wild-trainer/apps/app.cars.html').then(function (response) {
			// The API call was successful!
			console.log("Fetch worked!?");
			return response.text();
		}).then(function (html) {
			// This is the HTML from our response as a text string
			console.log(`Fetch worked! HTML->${html}`);

			var div = document.createElement("div");
			div.innerHTML = html;

			this.workArea = App.GetWorkspace();
			this.workArea.appendChild(div);
		}).catch(function (err) {
			// There was an error
			console.log('Something went wrong.', err);
		});