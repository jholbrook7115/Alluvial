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

#define NUM_OF_THREADS 4

bool FLAG_CLOSING;

struct spotify_credentials{
    int thread_id;
    QString username;
    QString password;
};

void *initSpotifyFromMain(void* sp_arguments){
    QtLibSpotify *spotifyObj = new QtLibSpotify("username", "password");

    while(!FLAG_CLOSING){

    }
    spotifyObj->closing();
}

int main(int argc, char *argv[])
{
    FLAG_CLOSING = false;
    pthread_t *spotifyThread;
    int spotifyThread_id;

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
    struct spotify_credentials spotifyCreds;

    spotifyCreds.thread_id=1;
    spotifyCreds.username = username.toString();
    spotifyCreds.password = password.toString();

    // Initializing the spotify stuff.  This particular is used for testing and SHOULD be changed later on.
    spotifyThread_id = pthread_create(spotifyThread, NULL, initSpotifyFromMain, (void*)&spotifyCreds);

    //QList<QObject *> parent=engine.rootObjects();

    //QQuickItem *searchbar = parent.findChild<QObject *>("");
            //  QObject::connect();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("clientSettings", settings);

    int appInt = app.exec();

    //On exit Code
    qDebug() << "Spotify:  Main Window Closing; Tell Spotify to release its current session";
    FLAG_CLOSING = true;

    return appInt;
}


