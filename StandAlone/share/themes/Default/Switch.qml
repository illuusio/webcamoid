/* Webcamoid, webcam capture application.
 * Copyright (C) 2019  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Templates 2.5 as T
import Ak 1.0
import "Private"

T.Switch {
    id: control
    icon.width: AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
    icon.height: AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth +
                            2 * implicitIndicatorWidth + implicitIndicatorHeight
                            + leftPadding + rightPadding)
    implicitHeight:
        Math.max(implicitBackgroundHeight + topInset + bottomInset,
                 implicitContentHeight + topPadding + bottomPadding,
                 2 * implicitIndicatorHeight + topPadding + bottomPadding)
    padding: AkUnit.create(4 * AkTheme.controlScale, "dp").pixels
    spacing: AkUnit.create(8 * AkTheme.controlScale, "dp").pixels
    hoverEnabled: true
    clip: true

    readonly property int animationTime: 100

    indicator: Item {
        id: sliderIndicator
        anchors.left: control.left
        anchors.leftMargin: switchThumb.width / 2 + control.leftPadding
        anchors.verticalCenter: control.verticalCenter
        implicitWidth:
            AkUnit.create(36 * AkTheme.controlScale, "dp").pixels
        implicitHeight:
            AkUnit.create(20 * AkTheme.controlScale, "dp").pixels

        Rectangle {
            id: switchTrack
            height: parent.height / 2
            color: AkTheme.shade(AkTheme.palette.active.window, -0.5)
            radius: height / 2
            anchors.verticalCenter: sliderIndicator.verticalCenter
            anchors.right: sliderIndicator.right
            anchors.left: sliderIndicator.left
        }
        Item {
            id: switchThumb
            width: height
            anchors.bottom: sliderIndicator.bottom
            anchors.top: sliderIndicator.top

            Rectangle {
                id: highlight
                width: control.visualFocus? 2 * parent.width: 0
                height: width
                color: switchThumbRect.color
                radius: width / 2
                anchors.verticalCenter: switchThumb.verticalCenter
                anchors.horizontalCenter: switchThumb.horizontalCenter
                opacity: control.visualFocus? 0.5: 0
            }
            Rectangle {
                id: switchThumbRect
                color: AkTheme.shade(AkTheme.palette.active.window, -0.1)
                radius: height / 2
                anchors.fill: parent
            }
        }
    }

    contentItem: Item {
        anchors.leftMargin: switchThumb.width / 2
        anchors.left: sliderIndicator.right
        anchors.rightMargin: control.rightPadding
        anchors.right: control.right

        IconLabel {
            id: iconLabel
            spacing: control.spacing
            mirrored: control.mirrored
            display: control.display
            iconName: control.icon.name
            iconSource: control.icon.source
            iconWidth: control.icon.width
            iconHeight: control.icon.height
            text: control.text
            font: control.font
            color: AkTheme.palette.active.windowText
            alignment: Qt.AlignLeft | Qt.AlignVCenter
            anchors.verticalCenter: control.contentItem.verticalCenter
            enabled: control.enabled
            elide: Text.ElideRight
        }
    }

    states: [
        State {
            name: "Disabled"
            when: !control.enabled

            PropertyChanges {
                target: switchTrack
                color: AkTheme.shade(AkTheme.palette.disabled.window, -0.5)
            }
            PropertyChanges {
                target: switchThumbRect
                color: AkTheme.shade(AkTheme.palette.disabled.window, -0.1)
            }
            PropertyChanges {
                target: iconLabel
                color: AkTheme.palette.disabled.windowText
            }
        },
        State {
            name: "Checked"
            when: control.checked
                  && !(control.hovered
                       || control.visualFocus
                       || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: switchTrack
                color: AkTheme.palette.active.highlight
            }
            PropertyChanges {
                target: switchThumbRect
                color: AkTheme.constShade(AkTheme.palette.active.highlight, 0.2)
            }
            PropertyChanges {
                target: switchThumb
                x: sliderIndicator.width - switchThumb.width
            }
        },
        State {
            name: "Hovered"
            when: !control.checked
                  && (control.hovered
                      || control.visualFocus
                      || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: switchTrack
                color: AkTheme.shade(AkTheme.palette.active.window, -0.6)
            }
            PropertyChanges {
                target: switchThumbRect
                color: AkTheme.shade(AkTheme.palette.active.window, -0.2)
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.5
            }
        },
        State {
            name: "CheckedHovered"
            when: control.checked
                  && (control.hovered
                      || control.visualFocus
                      || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: switchTrack
                color: AkTheme.constShade(AkTheme.palette.active.highlight, 0.1)
            }
            PropertyChanges {
                target: switchThumbRect
                color: AkTheme.constShade(AkTheme.palette.active.highlight, 0.3)
            }
            PropertyChanges {
                target: switchThumb
                x: sliderIndicator.width - switchThumb.width
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.5
            }
        },
        State {
            name: "Pressed"
            when: !control.checked
                  && control.pressed

            PropertyChanges {
                target: switchTrack
                color: AkTheme.shade(AkTheme.palette.active.window, -0.7)
            }
            PropertyChanges {
                target: switchThumbRect
                color: AkTheme.shade(AkTheme.palette.active.window, -0.3)
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.75
            }
        },
        State {
            name: "CheckedPressed"
            when: control.checked
                  && control.pressed

            PropertyChanges {
                target: switchTrack
                color: AkTheme.constShade(AkTheme.palette.active.highlight, 0.2)
            }
            PropertyChanges {
                target: switchThumbRect
                color: AkTheme.constShade(AkTheme.palette.active.highlight, 0.4)
            }
            PropertyChanges {
                target: switchThumb
                x: sliderIndicator.width - switchThumb.width
            }
            PropertyChanges {
                target: highlight
                width: 2 * switchThumb.width
                opacity: 0.75
            }
        }
    ]

    transitions: Transition {
        ColorAnimation {
            target: switchTrack
            duration: control.animationTime
        }
        PropertyAnimation {
            target: switchThumb
            properties: "x"
            duration: control.animationTime
        }
        ColorAnimation {
            target: switchThumbRect
            duration: control.animationTime
        }
        PropertyAnimation {
            target: highlight
            properties: "width,opacity"
            duration: control.animationTime
        }
    }
}
