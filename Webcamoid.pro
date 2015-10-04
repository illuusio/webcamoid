# Webcamoid, webcam capture application.
# Copyright (C) 2011-2015  Gonzalo Exequiel Pedone
#
# Webcamoid is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Webcamoid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
#
# Email   : hipersayan DOT x AT gmail DOT com
# Web-Site: http://github.com/hipersayanX/webcamoid

exists(commons.pri) {
    include(commons.pri)
} else {
    error("commons.pri file not found.")
}

TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += \
    Qb \
    StandAlone

OTHER_FILES = \
    .gitignore \
    README.md

# Install rules
unix {
     INSTALLS += desktop
    desktop.files = $${COMMONS_TARGET}.desktop
    desktop.path = $${DATAROOTDIR}/applications
}

INSTALLS += \
    license

license.files = COPYING
unix: license.path = $${LICENSEDIR}
!unix: license.path = $${PREFIX}
