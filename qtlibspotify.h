#ifndef QTLIBSPOTIFY_H
#define QTLIBSPOTIFY_H

#include <libspotify/api.h>
#include <QObject>



class QtLibSpotify:public QObject
{
public:
    bool FLAG_SPOTIFY_READY;

    QtLibSpotify();
    ~QtLibSpotify();
    int initSpotify(QString username, QString password);
    void searchSpotify(sp_session* session, QString searchQuery);
    void playSongSpotify(sp_session* session, sp_track* track);

public slots:
    sp_error spotifyLogin(sp_session *user_session, QString username, QString password);
    sp_error spotifyLogout(sp_session *user_session);

};

#endif // QTLIBSPOTIFY_H
