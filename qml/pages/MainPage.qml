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
            spacing: 3

            IconButton {
                icon.source: "image://theme/icon-camera-ec-minus05"
                onClicked: {
                    canvas.lineWidth--;
                }
            }

            IconButton {
                icon.source: "image://theme/icon-camera-ec-plus05"
                onClicked: {
                    canvas.lineWidth++;
                }
            }

            IconButton {
                icon.source: "image://theme/icon-m-clear"
                onClicked: {
                    clear = true;
                    canvas.requestPaint();
                }
            }
        }

        Rectangle {
            height: parent.height - menu.implicitHeight
            width: parent.width

            Canvas {
                id: canvas
                anchors.fill: parent
                antialiasing: true

                property real lineWidth: 1

                onLineWidthChanged: requestPaint()

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = "#ffffff";
                    ctx.lineCap = "round";
                    ctx.lineWidth = lineWidth;
                    ctx.strokeStyle = "#000000";

                    if (clear === true) {
                        ctx.fillRect(0, 0, width, height);
                        clear = false;
                    } else {
                        ctx.beginPath();
                        ctx.moveTo(startX, startY);
                        ctx.lineTo(finishX, finishY);
                        ctx.closePath();
                        ctx.stroke();
                        ctx.save();

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
