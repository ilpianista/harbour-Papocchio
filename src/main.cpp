/*
    Copyright (C) 2014-2016 Andrea Scarpino <me@andreascarpino.it>
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

#include <QtQuick>

#include <sailfishapp.h>

QString papocchioDir();

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    QCoreApplication::setApplicationName(QStringLiteral("Papocchio"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("it.andreascarpino"));

    view->setSource(SailfishApp::pathTo("qml/Papocchio.qml"));

    // Otherwise the Canvas is cleaned when the application is not
    // marked as active. See for more:
    // https://lists.sailfishos.org/pipermail/devel/2014-October/005065.html
    view->setPersistentOpenGLContext(true);
    view->setPersistentSceneGraph(true);

    view->rootContext()->setContextProperty("papocchioDir", papocchioDir());

    view->show();

    return app->exec();
}

/**
 * @brief papocchioDir just to be sure the directory where to save pictures
 *        exists.
 * @return the path to the directory where to save pictures.
 */
QString papocchioDir()
{
    const QDir papocchioDir(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)
                            + QDir::separator() + QCoreApplication::applicationName());

    if (!papocchioDir.exists()) {
        if (!papocchioDir.mkpath(papocchioDir.absolutePath())) {
            qCritical() << "Cannot create dir!";
        }
    }

    return QString(papocchioDir.absolutePath() + QDir::separator());
}
