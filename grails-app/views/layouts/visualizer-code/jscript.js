function playB() {
	var audioS = document.getElementById('audioE');
	if (audioS.paused) {
		audioS.play();
	}
	else {
		audioS.pause();
	}
}

// get the audio data
function getData() {
	// set up audio context, handles multiple browsers
	var audioCTX = new (window.AudioContext || window.webkitAudioContext)();
	
	var source = audioCTX.createBufferSource();
	var request = new XMLHttpRequest();
	
	// if running this script on a local computer, you must create a local server for this line to work 
	//(based on the way the open function works work)
	// http://localhost:8000/RollingStone.mp3
	request.open('GET', 'audio/files/RollingStone.mp3',true);
	request.responseType = 'arraybuffer';
	
	request.onload = function() {
		var audioData = request.response;
		
		audioCTX.decodeAudioData(audioData).then(function(decodedData) {
			var channelNum = decodedData.numberOfChannels;
			var dataArray = decodedData.getChannelData(0);
			
			// adds the channels to each other to get an overall volume
			// may not be the right way to find volume at a given time
			for(var i = 1; i < channelNum; i++) {
				for(var j = 0; j < decodedData.length; j++) {
					var addChannel = decodedData.getChannelData(i);
					dataArray[j] += addChannel[j];
				}
			}
			
		});
	}
	
	request.send();
}

document.body.onload = function() {
	// get audio start and start playing it
	var audioS = document.querySelector('#audioE');
	//audioS.play();
	
	// set up canvas context
	var canvas = document.querySelector('.visualizer');
	var canvasCTX = canvas.getContext("2d");
	
	getData();

	// Create fake audio data for visualizer
	var data = [];
	var arrayO = "";
	for(var i = 1; i < 11; i++) {
		for(var j = 1; j < 11; j++) {
			data.push(j);
		}
	}

	function visualize() {
		WIDTH = canvas.width;
		HEIGHT = canvas.height;
		
		canvasCTX.clearRect(0, 0, WIDTH, HEIGHT);
		
		function draw() {
			drawVisual = requestAnimationFrame(draw);
			
			canvasCTX.fillStyle = 'rgb(200, 200, 200)';
			canvasCTX.fillRect(0, 0, WIDTH, HEIGHT);
			
			canvasCTX.lineWidth = 2;
			canvasCTX.strokeStyle = 'rgb(0, 0, 0,)';
			
			canvasCTX.beginPath();
			
			var sliceWidth = WIDTH / data.length;
			var x = 0;
			
			for(var i = 0; i < data.length; i++) {
				var v = data[i] / 128.0;
				var y = v * HEIGHT/2;
				
				if(i === 0) {
					canvasCTX.moveTo(x, y);
				} else {
					canvasCTX.lineTo(x,y);
				}
				
				x += sliceWidth;
			}
			
			canvasCTX.lineTo(canvas.width, canvas.height/2);
			canvasCTX.stroke();
		};
		
		draw();
	}
	
	visualize();
};