/*
    Copyright (C) 2014-2015 Andrea Scarpino <me@andreascarpino.it>
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

    readonly property real defaultStrokeSize: 5
    readonly property real defaultRubberSize: 20
    readonly property color defaultStrokeColor: Qt.rgba(0, 0, 0, 1)
    readonly property color defaultFillColor: Qt.rgba(1, 1, 1, 1)

    Column {
        anchors.fill: parent

        Row {
            id: menu
            spacing: Theme.paddingMedium
            width: parent.width
            // Workaround: we don't want the Slider animation to resize this!
            height: Theme.itemSizeMedium

            IconButton {
                id: edit
                icon.source: "image://theme/icon-s-edit"
                anchors.verticalCenter: parent.verticalCenter
                width: 50

                // default value for the rubber
                property real prevLineWidth: defaultRubberSize;

                onClicked: {
                    if (canvas.strokeStyle == defaultStrokeColor) {
                        icon.source = "image://theme/icon-camera-focus"
                        canvas.strokeStyle = defaultFillColor;
                    } else {
                        icon.source = "image://theme/icon-s-edit"
                        canvas.strokeStyle = defaultStrokeColor;
                    }

                    // Remember the stroke/rubber size
                    var currentLineWidth = size.value;
                    size.value = prevLineWidth;
                    prevLineWidth = currentLineWidth;
                }
            }

            IconButton {
                id: save
                icon.source: "image://theme/icon-m-image"
                anchors.verticalCenter: parent.verticalCenter
                width: 50

                function pictureName() {
                    var dateTime = new Date();
                    return Qt.formatDateTime(dateTime, "yyyy-MM-dd-hh-mm-ss") + ".jpeg";
                }

                onClicked: {
                    remorseSave.execute(menu, qsTr("Saving the canvas..."), function() {
                        canvas.save(papocchioDir + pictureName());
                    }, 3000);
                }

                RemorseItem {
                    id: remorseSave
                }
            }

            Slider {
                id: size
                minimumValue: 1
                maximumValue: 30
                stepSize: 1
                value: defaultStrokeSize
                valueText: value
                width: parent.width - edit.width - save.width - clearBtn.width - (Theme.paddingMedium * 4)
                anchors.verticalCenter: parent.verticalCenter

                // Don't waste space
                leftMargin: 0
                rightMargin: 0

                onValueChanged: {
                    valueText = canvas.lineWidth = value;
                }
            }

            IconButton {
                id: clearBtn
                icon.source: "image://theme/icon-m-clear"
                anchors.verticalCenter: parent.verticalCenter
                width: 50

                onClicked: {
                    remorseClear.execute(menu, qsTr("Clearing the canvas..."), function() {
                        canvas.clear();
                    }, 3000);
                }

                RemorseItem {
                    id: remorseClear
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

                property int startX
                property int startY
                property int finishX
                property int finishY

                property bool initialize: true

                property real lineWidth: defaultStrokeSize
                property string strokeStyle: defaultStrokeColor

                onLineWidthChanged: requestPaint()

                function clear() {
                    var ctx = getContext("2d");
                    ctx.fillStyle = defaultFillColor;
                    ctx.fillRect(0, 0, width, height);
                    requestPaint();
                }

                onPaint: {
                    var ctx = getContext("2d");

                    // The context is not available in Component.onCompleted
                    // then we have to use a "exec-once workaround" to init
                    // the canvas background
                    if (initialize) {
                        clear();
                        initialize = false;
                    }

                    ctx.lineCap = "round";
                    ctx.lineJoin = "round";
                    ctx.lineWidth = lineWidth;
                    ctx.miterLimit = 1;
                    ctx.strokeStyle = strokeStyle;

                    ctx.beginPath();
                    ctx.moveTo(startX, startY);
                    ctx.lineTo(finishX, finishY);
                    ctx.closePath();
                    ctx.stroke();

                    startX = finishX;
                    startY = finishY;
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        parent.startX = parent.finishX = mouseX;
                        parent.startY = parent.finishY = mouseY;
                    }

                    onMouseXChanged: {
                        parent.finishX = mouseX;
                        parent.requestPaint();
                    }

                    onMouseYChanged: {
                        parent.finishY = mouseY;
                        parent.requestPaint();
                    }
                }
            }
        }
    }
}
