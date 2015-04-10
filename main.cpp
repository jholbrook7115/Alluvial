#include <QApplication>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QDebug>
#include <QUrl>
#include "settings_storage.h"
#include <QtQml>
#include <QtCore>
#include <thread>
#include <chrono>

#include <qtlibspotify.h>


int main(int argc, char *argv[])
{

    qmlRegisterSingletonType(QUrl("qrc:/GlobalVars.qml"), "Alluvial.Globals", 1, 0, "Globals");
    qmlRegisterType<Settings_storing>("AlluvialSettings", 0, 1, "ClientSettings");

	QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    app.setOrganizationName("AlluvialAlphaBuild");
    app.setOrganizationDomain("couponbug.com");
    app.setApplicationName("Alluvial");

    Settings_storing *settings = new Settings_storing();
    QVariant username = settings->value("spotifyUserName");
    QVariant password = settings->value("spotifyPassword");

    // Initializing the spotify stuff.  This particular is used for testing and SHOULD be changed later on.
    QtLibSpotify *spotifyObj = new QtLibSpotify();
    spotifyObj->initSpotify("jeffersonholbrook", "Quarantine2019)");

    //QList<QObject *> parent=engine.rootObjects();

    //QQuickItem *searchbar = parent.findChild<QObject *>("");
            //  QObject::connect();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("clientSettings", settings);


    //spotifyObj->spotifyLogin("holbrook002@gmail.com", "Quarantine2019)");
    //spotifyObj->search("Bruno Mars");

    int appInt = app.exec();

    //On exit Code
    qDebug() << "Spotify:  Main Window Closing; Tell Spotify to release its current session";
    emit spotifyObj->closing();

    return appInt;
}
