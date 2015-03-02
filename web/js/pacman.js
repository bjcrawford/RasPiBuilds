/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   pacman.js
 *  Date:   Feb 25, 2015
 *  Desc:   
 */



/**
 * Creates an animated pacman object.
 * 
 * @param {Canvas} canvas the canvas
 * @param {int} x the x coordinate of pacman center
 * @param {int} y the y coordinate of pacman center
 * @param {int} r the radius of pacman
 * @param {int} dx the horizontal velocity
 * @param {int} dy the vertical velocity
 * @returns {Pacman}
 */
var Pacman = function (canvas, x, y, r, dx, dy) {
    this.canvas = canvas;
    this.canvasContext = this.canvas.getContext("2d");
    this.x = x;
    this.y = y;
    this.r = r;
    this.dirOffset = 0;
    this.updateVelocity(dx, dy);
    this.count = 1;
};

/**
 * Updates the position of the pacman by a single frame.
 * 
 * @returns {undefined}
 */
Pacman.prototype.move = function () {
    // Restrict horizontal movement to the bounds of the canvas
    if (this.x + this.dx - this.r >= 5 && this.x + this.dx + this.r <= canvas.width - 5) {
        this.x = this.x + this.dx;
    }
    // restrict vertical movement to the bounds of the canvas
    if (this.y + this.dy - this.r >= 5 && this.y + this.dy + this.r <= canvas.height - 5) {
        this.y = this.y + this.dy;
    }
};

/**
 * Updates the pacman's velocity.
 * 
 * @param {int} dx the horizontal velocity
 * @param {int} dy the vertical velocity
 * @returns {undefined}
 */
Pacman.prototype.updateVelocity = function (dx, dy) {
    
    // Pacman can not move diagonally
    if(dx !== 0) {
        this.dx = dx;
        this.dy = 0;
    }
    else {
        this.dx = 0;
        this.dy = dy;
    }
    
    // Determine direction offset for drawing
    
    if (dx > 0 && dy === 0) { // Facing right
        this.dirOffset = 0.0;
    }
    else if (dx === 0 && dy > 0) { // Facing down
        this.dirOffset = 0.5;
    }
    else if (dx < 0 && dy === 0) { // Facing left
        this.dirOffset = 1.0;
    }
    else if (dx === 0 && dy < 0) { // Facing up
        this.dirOffset = 1.5;
    }
};

/**
 * Draws the pacman
 * 
 * @returns {undefined}
 */
Pacman.prototype.draw = function() {
    
    // The count is used in conjunction with a sin function 
    // to control the rotation associated with the top and 
    // bottom halves of the pacman giving the effect of the 
    // mouth opening and closing.
    this.count++;
    
    // Draw pacman
    this.canvasContext.fillStyle = 'yellow';

    // Draw top half of head
    this.canvasContext.beginPath();
    this.canvasContext.arc(pacman.x, pacman.y, pacman.r,
            (((Math.sin(this.count) + 1) / 8) + 2.75 + this.dirOffset) * Math.PI,
            (((Math.sin(this.count) + 1) / 8) + 1.75 + this.dirOffset) * Math.PI);
    this.canvasContext.closePath();
    this.canvasContext.fill();
    
    // Draw bottom half of head
    this.canvasContext.beginPath();
    this.canvasContext.arc(pacman.x, pacman.y, pacman.r,
            (((Math.sin(this.count + Math.PI) + 1) / 8) + 2 + this.dirOffset) * Math.PI,
            (((Math.sin(this.count + Math.PI) + 1) / 8) + 1 + this.dirOffset) * Math.PI);
    this.canvasContext.closePath();
    this.canvasContext.fill();
};