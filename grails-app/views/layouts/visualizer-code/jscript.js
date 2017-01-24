//set up audio context, handles multiple browsers
var audioCTX = new (window.AudioContext || window.webkitAudioContext)();
var audioS = document.getElementById('audioE');

var analyser = audioCTX.createAnalyser();

function playB() {
	var audioS = document.getElementById('audioE');
	if (audioS.paused) {
		audioS.play();
	}
	else {
		audioS.pause();
	}
}

document.body.onload = function() {
	var audioS = document.getElementById('audioE');
	audioS.play();
	
	// Error caused because canvas isn't loaded
	var canvas = document.getElementById('visualizer');
	alert(canvas);
	var ctx = canvas.getContext("2d");

	// Create fake audio data for visualizer
	var data = [];
	for(var i = 1; i < 11; i++) {
		for(var j = 1; j < 11; j++) {
			data.push(i);
		}
	}

	function visualize() {
		WIDTH = canvas.width;
		HEIGHT = canvas.height;
		
		ctx.clearRect(0, 0, WIDTH, HEIGHT);
		
		function draw() {
			drawVisual = requestAnimationFrame(draw);
			
			ctx.fillStyle = 'rgb(200, 200, 200)';
			ctx.fillRect(0, 0, WIDTH, HEIGHT);
			
			ctx.lineWidth = 2;
			ctx.strokeStyle = 'rgb(0, 0, 0,)';
			
			ctx.beginPath();
			
			var sliceWidth = WIDTH / data.length;
			var x = 0;
			
			for(var i = 0; i < data.length; i++) {
				var v = data[i] / 128.0;
				var y = v * HEIGHT/2;
				
				if(i === 0) {
					ctx.moveTo(x, y);
				} else {
					ctx.lineTo(x,y);
				}
				
				x += sliceWidth;
			}
			
			ctx.lineTo(canvas.width, canvas.height/2);
			ctx.stroke();
		};
		
		draw();
	}
	
	visualize();
};