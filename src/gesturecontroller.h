/*
    Copyright (C) 2026 Andrea Scarpino <andrea@scarpino.dev>
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

#ifndef GESTURECONTROLLER_H
#define GESTURECONTROLLER_H

#include <QObject>
#include <QQuickView>

class GestureController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool gesturesEnabled READ gesturesEnabled WRITE setGesturesEnabled NOTIFY
                   gesturesEnabledChanged)

public:
    explicit GestureController(QQuickView *view, QObject *parent = nullptr);
    virtual ~GestureController();

    bool gesturesEnabled() const;

public slots:
    void setGesturesEnabled(bool enabled);
    void toggleGestures();

private:
    void updateFlags();

    QQuickView *m_view;
    bool m_gesturesEnabled;

signals:
    void gesturesEnabledChanged();
};

#endif // GESTURECONTROLLER_H
