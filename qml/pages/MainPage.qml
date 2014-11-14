/*
    Copyright (C) 2014 Andrea Scarpino <me@andreascarpino.it>
    All rights reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    property int startX;
    property int startY;
    property int finishX;
    property int finishY;

    property bool clear: false

    Column {
        anchors.fill: parent

        Row {
            id: menu
            anchors.horizontalCenter: parent.horizontalCenter
            // Workaround: we don't want the Slider animation!
            height: 95
            spacing: 3

            IconButton {
                icon.source: "image://theme/icon-camera-focus"
                anchors.verticalCenter: parent.verticalCenter

                // default value for the rubber
                property real prevLineWidth: 20;

                onClicked: {
                    if (canvas.strokeStyle === "#000000") {
                        canvas.strokeStyle = "#ffffff";
                    } else {
                        canvas.strokeStyle = "#000000";
                    }

                    var currentLineWidth = size.value;
                    size.value = prevLineWidth;
                    prevLineWidth = currentLineWidth;
                }
            }

            Slider {
                id: size
                minimumValue: 1
                maximumValue: 30
                stepSize: 1
                value: 5
                valueText: value
                width: 400
                // Workaround: we don't want the Slider animation!
                height: 120

                onValueChanged: {
                    valueText = canvas.lineWidth = value;
                }
            }

            IconButton {
                icon.source: "image://theme/icon-m-clear"
                anchors.verticalCenter: parent.verticalCenter

                onClicked: {
                    clear = true;
                    canvas.requestPaint();
                }
            }
        }

        Rectangle {
            height: parent.height - menu.height
            width: parent.width

            Canvas {
                id: canvas
                anchors.fill: parent
                antialiasing: true

                property real lineWidth: 1
                property string strokeStyle: "#000000"

                onLineWidthChanged: requestPaint()

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = "#ffffff";
                    ctx.lineCap = "round";
                    ctx.lineJoin = "round";
                    ctx.lineWidth = lineWidth;
                    ctx.miterLimit = 1;
                    ctx.strokeStyle = strokeStyle;

                    if (clear === true) {
                        ctx.fillRect(0, 0, width, height);
                        clear = false;
                    } else {
                        ctx.beginPath();
                        ctx.moveTo(startX, startY);
                        ctx.lineTo(finishX, finishY);
                        ctx.closePath();
                        ctx.stroke();

                        startX = finishX;
                        startY = finishY;
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        startX = finishX = mouseX;
                        startY = finishY = mouseY;
                    }

                    onMouseXChanged: {
                        finishX = mouseX;
                        parent.requestPaint();
                    }

                    onMouseYChanged: {
                        finishY = mouseY;
                        parent.requestPaint();
                    }
                }
            }
        }
    }
}
