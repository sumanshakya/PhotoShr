(function() {
	var filesUpload = document.getElementById("files-upload"), 
	dropArea = document.getElementById("drop-area"), fileList = document.getElementById("file-list"),
	uploadFormUrl = $("#uploadForm").attr('action');

	function uploadFile(file) {
		var uploadContainer = document.createElement("div"),
			div = document.createElement("div"),			
			img, 			
			reader, 
			xhr, 
			fileInfo;

		uploadContainer.appendChild(div);

		//progressBarContainer.className = "progress-bar-container";
		//progressBar.className = "progress-bar";
		//progressBarContainer.appendChild(progressBar);
		//uploadContainer.appendChild(progressBarContainer);

		/*
		 * If the file is an image and the web browser supports FileReader,
		 * present a preview in the file list
		 */
		if (typeof FileReader !== "undefined" && (/image/i).test(file.type)) {			
			img = document.createElement("img");
			uploadContainer.appendChild(img);
			reader = new FileReader();
			reader.onload = (function(theImg) {
				return function(evt) {
					theImg.src = evt.target.result;
					$(theImg).attr("class","img-polaroid");
					$(theImg).css({
						"max-width":"800px"
					});
				};
			}(img));
			reader.readAsDataURL(file);
		}

		// Uploading - for Firefox, Google Chrome and Safari
//		xhr = new XMLHttpRequest();
//
//		// Update progress bar
//		xhr.upload.addEventListener("progress", function(evt) {
//			if (evt.lengthComputable) {
//				progressBar.style.width = (evt.loaded / evt.total) * 100 + "%";
//			} else {
//				// No data to calculate on
//			}
//		}, false);

		// File uploaded
//		xhr.addEventListener("load", function() {
//			progressBarContainer.className += " uploaded";
//			progressBar.innerHTML = "Uploaded!";
//		}, false);

//		xhr.open("post", uploadFormUrl, true);
//
//		// Set appropriate headers
//		xhr.setRequestHeader("Content-Type", "multipart/form-data");
//		xhr.setRequestHeader("X-File-Name", file.name);
//		xhr.setRequestHeader("X-File-Size", file.size);
//		xhr.setRequestHeader("X-File-Type", file.type);
//
//		// Send the file (doh)
//		xhr.send(file);

		// Present file info and append it to the list of files
		fileInfo = "<div><strong>Name:</strong> " + file.name + "</div>";
		fileInfo += "<div><strong>Size:</strong> "
				+ parseInt(file.size / 1024, 10) + " kb</div>";
		fileInfo += "<div><strong>Type:</strong> " + file.type + "</div>";
		div.innerHTML = fileInfo;

		fileList.appendChild(uploadContainer);
		
		
	}

	function traverseFiles(files) {
		if (typeof files !== "undefined") {
			for ( var i = 0, l = files.length; i < l; i++) {
				uploadFile(files[i]);
			}
			$('#file-metadata').show();
			
		} else {
			fileList.innerHTML = "No support for the File API in this web browser";
		}
	}

	filesUpload.addEventListener("change", function() {
		traverseFiles(this.files);
	}, false);
	
})();
