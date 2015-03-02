/* 
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   raspberry.js
 *  Date:   Mar 2, 2015
 *  Desc:
 */

/**
 * Creates a raspberry object
 * 
 * @param {Canvas} canvas the canvas
 * @param {int} x the x coordinate of raspberry center
 * @param {int} y the y coordinate of raspberry center
 * @param {int} dx the horizontal velocity
 * @param {int} dy the vertical velocity
 * @param {int} width the width of the raspberry
 * @param {int} height the height of the raspberry
 * @param {boolean} visible the visibility of the raspberry
 * @returns {Raspberry}
 */
var Raspberry = function (canvas, x, y, dx, dy, width, height, visible) {
    this.canvas = canvas;
    this.canvasContext = this.canvas.getContext("2d");
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.width = width;
    this.height = height;
    this.visible = visible;
    this.img = document.getElementById("raspberry");
};

/**
 * Updates the position of the raspberry by a single frame. On collision with
 * walls, reverse direction.
 * 
 * @returns {undefined}
 */
Raspberry.prototype.move = function () {
    if (this.visible) {
        if (this.x - (this.width/2) + this.dx < 5 || this.x + (this.width/2) + this.dx > this.canvas.width - 5) {
            this.dx = -this.dx;
        }
        if (this.y - (this.height/2) + this.dy < 5 || this.y + (this.height/2) + this.dy > this.canvas.height - 5) {
            this.dy = -this.dy;
        }
        this.x = this.x + this.dx;
        this.y = this.y + this.dy;
    }
};

/**
 * Draws the raspberry
 * 
 * @returns {undefined}
 */
Raspberry.prototype.draw = function () {
    if (this.visible) {
        this.canvasContext.drawImage(this.img, this.x - (this.width/2), this.y - (this.height/2), this.width, this.height);
    }
};