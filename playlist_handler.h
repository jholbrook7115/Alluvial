#ifndef PLAYLIST_HANDLER_H
#define PLAYLIST_HANDLER_H
#include <vector>
#include <playlist.h>
#include <QObject>
#include <QStringList>
#include <QQmlApplicationEngine>

class playlist_handler:public QObject
{
    Q_OBJECT

public:
    playlist_handler();
    ~playlist_handler();

    void addPlaylist();
    void addPlaylist(playlist);
    void addPlaylist(QString);
    void addSong(int, playlist_item);
    void dropPlaylists();
    void dropPlaylist(playlist);
    void dropPlaylist(QString);
    void dropSong(int, playlist_item);

    std::vector<playlist> getPlaylists();
    playlist getPlaylist(int);
    std::vector<QString> getPlaylistNames();
    std::vector<QString> getPlaylistSongNames(int);
    playlist getActivePlaylist();
    int getActivePlaylistIndex();
    int getActiveSongIndex();
    QString getActiveSongHash();
    bool getShuffle();
    bool getRepeat();

    void jumpToSong(QString);
    void jumpToSong(int);
    void setActivePlaylistIndex(int);
    void setActiveSongIndex(int);
    void setShuffle(bool);
    void setRepeat(bool);

public slots:
    void repeatSwitch();
    void shuffleSwitch();
    void changePlaylist(int);
    void changeTrackListings(int);
    void changePlaylist(QString);
    void previousSong();
    void nextSong();

signals:
    void setTrackListings(QStringList list);

private:
    std::vector<playlist> playlists; /**< Vector of all playlist structures */
    int activePlaylist; /**< The index of the current active playlist */
    int activeSong; /**< The index of the current song that is playing */
    bool shuffle; /**< Boolean indicator - shuffle activated */
    bool repeat; /**< Boolean indicator - repeat activated */
};

#endif // PLAYLIST_HANDLER_H
