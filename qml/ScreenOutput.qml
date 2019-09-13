/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.8
import QtWayland.Compositor 1.0
import QtQuick.Window 2.3

WaylandOutput {
    id: screenoutput
    property variant viewsBySurface: ({})
    property alias surfaceArea: background
    property alias text: t.text
    property alias screen: win.screen
    property int index: 0

    sizeFollowsWindow: true


    onPositionChanged: {
        console.log("screen:"+t.text+" virtual position:"+position)
    }

    window: Window {
        id: win

        visibility:"FullScreen"
        visible: true


        Rectangle {
            //                anchors.fill: parent
            id: background
            rotation: screenoutput.text=="eDP1"?90:0

            Behavior on rotation {
                NumberAnimation { duration: 1000 }
            }

            anchors.centerIn: parent
            width: win.width
//            onWidthChanged: {
//                if(screen.toplevel){
//                    console.log("screen.text : onWidthChanged:"+width)
////                    screen.toplevel.sendMaximized(Qt.size(width, height));
//                }


//            }

            Component.onCompleted: {

            }

            height: win.height
//            onHeightChanged: {
//                if(screen.toplevel){

//                    screen.toplevel.sendMaximized(Qt.size(width, height));
//                }
//            }

            states: [
                State {
                    name: "landscape"
                    when: background.rotation == 0
                },
                State {
                    name: "portrait"
                    when: background.rotation == 90
                    PropertyChanges {
                        target: background
                        width: win.height
                        height: win.width
                    }
                },
                State {
                    name: "invertedlandscape"
                    when: background.rotation == 180
                },
                State {
                    id: "invertedportrait"
                    when: background.rotation == 270
                    PropertyChanges {
                        target: background
                        width: win.height
                        height: win.width
                    }
                }
            ]


            Text {
                id: t
                anchors.centerIn: parent
                font.pointSize: 72
            }
        }

        //            WaylandCursorItem {
        //                inputEventsEnabled: false
        //                x: mouseTracker.mouseX
        //                y: mouseTracker.mouseY
        //                seat: comp.defaultSeat
        //                visible: mouseTracker.containsMouse
        //            }

        //        }

        Shortcut {
            sequence: "Ctrl+Alt+Backspace"
            onActivated: Qt.quit()
        }
    }
}
