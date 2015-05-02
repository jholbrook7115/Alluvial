#ifndef MEDIAHANDLER_H
#define MEDIAHANDLER_H
#include <QObject>
#include <QJsonObject>
#include <QString>
#include <QVector>
#include <QQueue>
#include <QStringList>
#include <QMap>
#include <QFile>

#include "searchresult.h"
#include "simplecrypt.h"
#include "Local/queryhandler.h"
#include "Local/songhandler.h"
#include "Soundcloud/schandler.h"
#include "Spotify/qtspotifysession.h"

///TODO: Re-add spotify

class MediaHandler : public QObject
{
    Q_OBJECT
public:
    explicit MediaHandler(QObject *parent = 0);
    ~MediaHandler();

    void search(QString query);
    QByteArray getMediaFromHash(QString hash);
    void retrievePlaylist(QString name);
    void savePlaylist(QJsonObject playlist);

    SimpleCrypt *crypto;

signals:
    void searchResultComplete(QJsonObject res);
    void getPlaylistComplete(QJsonObject res);


public slots:
private:

    QtSpotifySession *spotify;
    SCHandler *soundcloud;
    queryhandler *db;
    songHandler *dbSongs;
    QQueue<SearchResult*> *searchQueue;
    QMap<QString, SearchResult*> *completedSearches;
    
//    unsigned int levenshtein_distance(QString s1, QString s2);

private slots:
    void processQueue();

};

#endif // MEDIAHANDLER_H
