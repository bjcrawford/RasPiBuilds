/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   pacmanAnimation.js
 *  Date:   Feb 25, 2015
 *  Desc:
 */

var canvas;
var canvasContext;
var pacman;
var raspberries;
var timerID;
var toggleValue = 1;
var exitButton;
var startTime;


function initializeCanvas() {
    canvas = document.getElementById("pacman-canvas");

    // The canvas starts out hidden from the user
    $("#pacman-canvas").hide();
    $("#pacman-exit-button").hide();

    // Set event handlers for animation enter/exit buttons
    $("#raspberry").click(initializePacman);
    $("#pacman-exit-button").click(terminatePacman);
};

/**
 * Initializes the pacman animation.
 * 
 * @returns {undefined}
 */
function initializePacman() {

    alert("Use the arrow keys to control pacman.");

    $("#pacman-canvas").show();
    $("#pacman-exit-button").show();

    canvas.width = window.innerWidth - 20;
    canvas.height = window.innerHeight;
    canvasContext = canvas.getContext('2d');

    // Keep the canvas fullscreen when the browser window is resized
    window.onresize = function () {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    };

    // Create a pacman and a bunch of raspberries with random velocities
    pacman = new Pacman(canvas, 70, 105, 30, 0, 0);
    raspberries = [
        new Raspberry(canvas, 100, 175, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 200, 175, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 300, 175, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 400, 175, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 100, 250, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 200, 250, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 300, 250, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 400, 250, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 100, 325, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 200, 325, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 300, 325, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 400, 325, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 100, 400, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 200, 400, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 300, 400, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true),
        new Raspberry(canvas, 400, 400, Math.floor((Math.random() * 11) - 5), Math.floor((Math.random() * 11) - 5), 16, 20, true)];

    // On arrow key presses, move pacman
    $(document).bind("keydown", function (event) {
        event.preventDefault();
        var keycode = (event.keyCode ? event.keyCode : event.which);

        if (keycode === 38) { // Up
            pacman.updateVelocity(0, -10);
        }
        else if (keycode === 40) { // Down
            pacman.updateVelocity(0, 10);
        }
        else if (keycode === 37) { // Left
            pacman.updateVelocity(-10, 0);
        }
        else if (keycode === 39) { // Right
            pacman.updateVelocity(10, 0);
        }
    });

    // On arrow key releases, stop the pacman from moving
    $(document).bind("keyup", function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);

        if (keycode === 38) { // Up
            pacman.updateVelocity(pacman.dx, 0);
        }
        else if (keycode === 40) { // Down
            pacman.updateVelocity(pacman.dx, 0);
        }
        else if (keycode === 37) { // Left
            pacman.updateVelocity(0, pacman.dy);
        }
        else if (keycode === 39) { // Right
            pacman.updateVelocity(0, pacman.dy);
        }
    });

    // Set the refresh rate, record the timer ID
    timerID = setInterval(drawFrame, 50);
    
    // Record start time
    startTime = new Date();
};

/**
 * Terminates the pacman animation
 * 
 * @returns {undefined}
 */
function terminatePacman() {
    // Clear and hide the canvas
    clearCanvas();
    $("#pacman-canvas").hide();
    $("#pacman-exit-button").hide();

    // Remove the keydown and keyup event handlers
    $(document).unbind("keydown");
    $(document).unbind("keyup");

    // Destroy objects
    canvasContext = null;
    pacman = null;
    raspberries = null;

    // Remove the interval timer
    clearInterval(timerID);
    timerID = null;
};

/**
 * Draws a single frame of the animation.
 * 
 * @returns {undefined}
 */
function drawFrame() {
    clearCanvas();

    // Draw background
    canvasContext.fillStyle = "black";
    canvasContext.fillRect(5, 5, canvas.width - 10, canvas.height - 10);
    
    canvasContext.beginPath();
    canvasContext.lineWidth="4";
    canvasContext.strokeStyle="blue";
    canvasContext.rect(6, 6, canvas.width - 12, canvas.height - 12);
    canvasContext.stroke();

    // Update pacman postion
    pacman.move();

    var win = true;
    for (i = 0; i < raspberries.length; i++) {
        // Handle raspberry consumption
        if (pacman.x - pacman.r / 2 < raspberries[i].x && pacman.x + pacman.r / 2 > raspberries[i].x &&
                pacman.y - pacman.r / 2 < raspberries[i].y && pacman.y + pacman.r / 2 > raspberries[i].y) {
            raspberries[i].visible = false;
        }

        if (raspberries[i].visible) {
            win = false;
        }

        // Update raspberry position
        raspberries[i].move();

        // Draw raspberries
        raspberries[i].draw();
    }

    // If all raspberries have been consumed, handle win situation
    if (win) {
        var endTime = new Date();
        var timeElapsed = (endTime - startTime);
        var milliseconds = Math.round(timeElapsed % 1000);
        timeElapsed = Math.floor(timeElapsed / 1000);
        var seconds = Math.round(timeElapsed % 60);
        timeElapsed = Math.floor(timeElapsed / 60);
        var minutes = Math.round(timeElapsed % 60);
        timeElapsed = Math.floor(timeElapsed / 60);
        alert("You win! Your time was: " + pad(minutes, 2) + ":" + pad(seconds, 2) + ":" + pad(milliseconds, 3));
        terminatePacman();
    }

    // Draw pacman on top of raspberries
    pacman.draw();
};

/**
 * Clears the canvas
 * 
 * @returns {undefined}
 */
function clearCanvas() {
    canvasContext.clearRect(0, 0, canvas.width, canvas.height);
};

/**
 * Pads a number with leading zeroes and returns the string representation.
 * 
 * @param {type} num the number to pad
 * @param {type} size the minimum number of digits in the result
 * @returns {String|pad.s}
 */
function pad(num, size) {
    var s = num + "";
    while (s.length < size) {
        s = "0" + s;
    }
    return s;
};
