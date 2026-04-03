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

#include "gesturecontroller.h"

GestureController::GestureController(QQuickView *view, QObject *parent)
    : QObject(parent)
    , m_view(view)
    , m_gesturesEnabled(true)
{}

GestureController::~GestureController() {}

bool GestureController::gesturesEnabled() const
{
    return m_gesturesEnabled;
}

void GestureController::setGesturesEnabled(bool enabled)
{
    if (m_gesturesEnabled != enabled) {
        m_gesturesEnabled = enabled;
        updateFlags();
        emit gesturesEnabledChanged();
    }
}

void GestureController::toggleGestures()
{
    setGesturesEnabled(!m_gesturesEnabled);
}

void GestureController::updateFlags()
{
    if (m_view) {
        Qt::WindowFlags flags = m_view->flags();
        if (m_gesturesEnabled) {
            flags &= ~Qt::WindowOverridesSystemGestures;
        } else {
            flags |= Qt::WindowOverridesSystemGestures;
        }
        m_view->setFlags(flags);
    }
}
