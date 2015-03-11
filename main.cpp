#include <QApplication>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QDebug>
#include <QUrl>
#include "settings_storage.h"






/*
Settings::Settings(QObject *parent): QObject(parent){

}

void Settings::setValue(const QString &key, const QVariant &value){
    client_settings.setValue(key, value);
}
QVariant Settings::value(const QString &key, const QVariant &defaultValue) const{
    return client_settings.value(key, defaultValue);
}
*/

int main(int argc, char *argv[])
{
    QUrl url("file:///home/jefferson/Code/Alluvial/Alluvial/main.qml");
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    app.setOrganizationName("AlphaBuilders");
    app.setOrganizationDomain("couponbug.com");
    app.setApplicationName("Alluvial");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    /*
     * IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     * ("../Alluvial/main.qml")
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     * IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    QQuickView *view = new QQuickView;
    QScopedPointer<QApplication> application(new QApplication(argc, argv));
    //QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());
    Settings* settings = new Settings(application.data());
    QUrl url("file:///home/jefferson/Code/Alluvial/Alluvial");


    view->rootContext()->setContextProperty("settings", settings);
    view->setSource();
    view->showNormal();

   // engine = new QQmlEngine;
   // QQmlEngine *qmlengine = new QQmlEngine;
   // qmlengine->rootContext()->setContextProperty("settings", settings);
   //  component = new QQmlComponent(qmlengine);



    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    window->show();
*/
    return app.exec();
}
