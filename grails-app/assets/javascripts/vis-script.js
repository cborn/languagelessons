
//function for the play button
function playB() {
	var audioS = document.getElementById('audioE');
	if (audioS.paused) {
		audioS.play();
	}
	else {
		audioS.pause();
	}
}

function getData() {
	// set up audio context, handles multiple browsers
	
	var audioCTX = new (window.AudioContext || window.webkitAudioContext)();

	var source = audioCTX.createBufferSource();
	var request = new XMLHttpRequest();
	
	var dataArray = [];
	
	request.open('GET', 'RollingStone.mp3');
	request.responseType = 'arraybuffer';
	
	request.onload = function() {
		var audioData = request.response;
		
		audioCTX.decodeAudioData(audioData).then(function(decodedData) {
			var channelNum = decodedData.numberOfChannels;
			
			// displays first 12 seconds of audio
			// if you want to display the whole audio clip, delete slice and pass dataArray into visualize()
			// only takes first channel, multi channel audio not yet supported
			// assumes 48k sample rate
			dataArray = decodedData.getChannelData(0);
			slice = dataArray.slice(0*48000,12*48000);
			
			visualize(slice);
		});
		
	}
	
	request.send();	
}

function visualize(data) {
	var canvas = document.querySelector('.visualizer');
	var canvasCTX = canvas.getContext("2d");
	
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
		
		// should change the bar height to be based on the maximum in data
		// this only works if data is relatively small, otherwise it would take too long
		for(var i = 0; i < data.length; i++) {
			var v = data[i] * 20000.0;
			var y = HEIGHT - v/HEIGHT;
			
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

document.body.onload = function() {
	var audioS = document.querySelector('#audioE');
	
	getData();
};

// commented out to prevent script from trying to load on every page
/*document.body.onload = function() {
	var audioS = document.querySelector('#audioE');
	
	getData();
};*/
