/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQml 2.2
import QtQuick 2.0

import QtWayland.Compositor 1.3
import QtQml.Models 2.1

WaylandCompositor {
    id: comp




    ScreenManager{
        id:screenmanager
    }



    Component {
        id: chromeComponent
        Chrome {

        }
    }

    ListModel {
        id: shell_surfaces
    }

    Component {
        id: moveItemComponent
        Item {


//            onXChanged: {
//                console.log("x:"+x)
////                if(shellSurface.toplevel){
////                    shellSurface.toplevel.sendMaximized(Qt.size(800,1280))
////                }
//            }


//            com
            //            screen.toplevel.sendMaximized(Qt.size(w, h));

//            Component.onCompleted: {
//                console.log("moveItem on pos:"+x);
//            }
        }
    }

    Item {
        id: rootItem
    }

    WlShell {
        onWlShellSurfaceCreated: handleShellSurfaceCreated(shellSurface)
    }

    XdgShellV6 {
        onToplevelCreated: handleShellSurfaceCreated(xdgSurface)
    }



    XdgShell {
        onToplevelCreated: {
            handleShellSurfaceCreated(xdgSurface)
        }


    }



    function createShellSurfaceItem(shellSurface, moveItem, screenOutput) {
        var parentSurfaceItem = screenOutput.viewsBySurface[shellSurface.parentSurface];
        var parent = parentSurfaceItem || screenOutput.surfaceArea;
        var item = chromeComponent.createObject(parent, {
                                                    "shellSurface": shellSurface,
                                                    "moveItem": moveItem,
                                                    "screenOutput":screenOutput
                                                });
        if (parentSurfaceItem) {
            item.x += screenOutput.position.x;
            item.y += screenOutput.position.y;
        }


        screenOutput.viewsBySurface[shellSurface.surface] = item;





    }

    function handleShellSurfaceCreated(shellSurface) {

        shell_surfaces.append(shellSurface)

        var moveItem = moveItemComponent.createObject(rootItem);

        for (var i =0 ;i< screenmanager.screens.count; ++i){


            createShellSurfaceItem(shellSurface, moveItem, screenmanager.screens.objectAt(i));
        }



    }
}
