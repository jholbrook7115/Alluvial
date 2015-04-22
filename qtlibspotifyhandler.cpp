#include "qtlibspotifyhandler.h"
#include "qtlibspotify.h"
#include <QThread>
#include <QDebug>

QtLibSpotify *objlibSpotify;
QThread *spotifyThread;




QtLibSpotifyHandler::QtLibSpotifyHandler(QObject *parent) : QObject(parent)
{
    qDebug() << "QtlibSpotifyHandler: default constructor called";
}

QtLibSpotifyHandler::~QtLibSpotifyHandler()
{

}

QtLibSpotifyHandler::QtLibSpotifyHandler(QString username, QString password)
{
    uname = username;
    pword = password;
    QtLibSpotifyWorker *spotifyWorker = new QtLibSpotifyWorker();
    spotifyWorker->moveToThread(&spotifyThread);
    connect(&spotifyThread, &QThread::started, spotifyWorker, &QtLibSpotifyWorker::doWork);
    connect(&spotifyThread, &QThread::finished, spotifyWorker, &QObject::deleteLater);
    connect(this, &QtLibSpotifyHandler::startWorking, spotifyWorker, &QtLibSpotifyWorker::doWork);
    connect(spotifyWorker, &QtLibSpotifyWorker::returnDataStream, this, &QtLibSpotifyHandler::dataStreamCB);
    spotifyThread.start();


}

void QtLibSpotifyHandler::searchQtlibSpotify(QString searchString)
{
    objlibSpotify->search(searchString);
}

void QtLibSpotifyHandler::dataStreamCB(QByteArray datastream)
{

}

void QtLibSpotifyHandler::searchResultsCB(QJsonArray serachResults)
{

}

void QtLibSpotifyHandler::searchSlot(QString query){
    qDebug() << "QtLibSpotifyhandlerSearch: searchSlot has received a query!";
    searchQtlibSpotify(query);
}
