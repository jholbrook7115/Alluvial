#ifndef PLAYLIST_H
#define PLAYLIST_H
#include <QObject>
#include <QString>
#include <playlist_item.h>
#include <vector>

class playlist
{

public:
    playlist();
    playlist(QString);
    ~playlist();
    void jumpToSong(QString);
    void jumpToSong(int);
    void addSong(playlist_item);
    void removeSong(playlist_item);
    void moveSong(playlist_item, int);
    QString getActiveSongHash();
    QString getSongHash(int);
    QString getPlaylistTitle();
    QString name();
    std::vector<playlist_item> getSongs();
    playlist_item getSong(int);

public slots:

private:
    QString title;
    std::vector<playlist_item> songs{}; /**< The array of the songs that belong to this playlist */
};

#endif // PLAYLIST_H
