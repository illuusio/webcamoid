/* Webcamoid, webcam capture application.
 * Copyright (C) 2011-2015  Gonzalo Exequiel Pedone
 *
 * Webcamod is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamod is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamod. If not, see <http://www.gnu.org/licenses/>.
 *
 * Email   : hipersayan DOT x AT gmail DOT com
 * Web-Site: http://github.com/hipersayanX/webcamoid
 */

#ifndef QUARKELEMENT_H
#define QUARKELEMENT_H

#include <QQmlComponent>
#include <QQmlContext>
#include <qb.h>
#include <qbutils.h>

class QuarkElement: public QbElement
{
    Q_OBJECT
    Q_PROPERTY(int planes
               READ planes
               WRITE setPlanes
               RESET resetPlanes
               NOTIFY planesChanged)

    public:
        explicit QuarkElement();

        Q_INVOKABLE QObject *controlInterface(QQmlEngine *engine,
                                              const QString &controlId) const;

        Q_INVOKABLE int planes() const;

    private:
        int m_planes;

        QbElementPtr m_convert;
        QbCaps m_caps;
        QImage m_buffer;
        int m_plane;
        QVector<QRgb *> m_planeTable;

    signals:
        void planesChanged();

    public slots:
        void setPlanes(int planes);
        void resetPlanes();

        QbPacket iStream(const QbPacket &packet);
};

#endif // QUARKELEMENT_H
