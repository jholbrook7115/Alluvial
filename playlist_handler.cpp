#include "playlist_handler.h"
#include "playlist.h"
#include "dataobject.h"
#include <vector>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QAbstractListModel>
#include <QQmlContext>
#include <QQuickView>

/*!
 * \brief playlist_handler::playlist_handler The wrapper for all playlists to be saved.
 * The playlist wrapper will save indices for which playlist being used and
 * an index for which song is being played in the currently active playlist.
 *
 * Two boolean indicators will be used to save playback options.
 */
playlist_handler::playlist_handler()
{
    this->playlists = std::vector<playlist>();
    this->activePlaylist = 0;
    this->activeSong = 0;
    this->shuffle = false;
    this->repeat = false;
}

playlist_handler::~playlist_handler()
{

}

/*!
 * \brief playlist_handler::addPlaylist Add a new playlist to the beginning of the list. Default titled.
 */
void playlist_handler::addPlaylist()
{
    playlist *newPlaylist = new playlist();
    this->playlists.insert(this->playlists.end(), *newPlaylist);
}

/*!
 * \brief playlist_handler::addPlaylist Add a playlist to the beginning of the list
 * \param newPlaylist The playlist to be added
 */
void playlist_handler::addPlaylist(playlist newPlaylist)
{
    this->playlists.insert(this->playlists.end(), newPlaylist);
}

/*!
 * \brief playlist_handler::addPlaylist Add a playlist to the beginning of the list
 * \param playlistTitle The title of the playlist to be added.
 */
void playlist_handler::addPlaylist(QString playlistTitle)
{
    playlist *newPlaylist = new playlist(playlistTitle);
    this->playlists.insert(this->playlists.end(), *newPlaylist);
}

void playlist_handler::addSong(int playlistIndex, playlist_item songToAdd)
{
    this->playlists.at(playlistIndex).addSong(songToAdd);
}

/*!
 * \brief playlist_handler::dropPlaylists Remove all playlists from the list
 */
void playlist_handler::dropPlaylists()
{
    this->playlists.erase(this->playlists.begin(),this->playlists.end());
}

/*!
 * \brief playlist_handler::dropPlaylist Remove a playlist from the list
 * \param playlistToDrop The playlist item to be dropped.
 */
void playlist_handler::dropPlaylist(playlist playlistToDrop)
{
    for ( int index = 0 ; index < this->playlists.size() ; index++ )
    {
        if ( this->playlists[index].getPlaylistTitle() == playlistToDrop.getPlaylistTitle())
        {
            this->playlists.erase(this->playlists.begin() + index);
            break;
        }
    }
}

/*!
 * \brief playlist_handler::dropPlaylist Remove a playlist from the list
 * \param playlistTitleToDrop The title of the playlist to drop
 */
void playlist_handler::dropPlaylist(QString playlistTitleToDrop)
{
    for ( int index = 0 ; index < this->playlists.size() ; index++ )
    {
        if ( this->playlists[index].getPlaylistTitle() == playlistTitleToDrop)
        {
            this->playlists.erase(this->playlists.begin() + index);
            break;
        }
    }
}

void playlist_handler::dropSong(int playlistIndex, playlist_item songToDrop)
{
    this->playlists.at(playlistIndex).removeSong(songToDrop);
}

/*!
 * \brief The playlist incrementer
*/
void playlist_handler::nextSong()
{
    this->activeSong = this->activeSong + 1;
    if ( this->activeSong >= this->playlists.at(this->activePlaylist).getSongs().size() )
    {
        this->activeSong = 0;
    }

    qDebug() << "Active Song Index:" << this->activeSong;

}

/*!
 * \brief The playlist decrementer
 */
void playlist_handler::previousSong()
{
    this->activeSong = this->activeSong - 1;
    if ( this->activeSong < 0 )
    {
        this->activeSong = this->playlists.at(activePlaylist).getSongs().size() - 1;
    }
    qDebug() << "Active Song Index:" << this->activeSong;
}

/*!
 * \brief playlist::jumpToSong Jump to song by hash
 * \param newSongHash The hash of the song we want to jump to
 */
void playlist_handler::jumpToSong(QString newSongHash)
{
    for ( int index = 0; index < this->playlists.at(this->activePlaylist).getSongs().size() ; index++ )
    {
        if ( this->playlists.at(this->activePlaylist).getSongs()[index].getHash() == newSongHash )
        {
            this->activeSong = index;
            break;
        }
    }
}

/*!
 * \brief playlist::jumpToSong Skip to song position
 * \param newIndex The index to jump to
 */
void playlist_handler::jumpToSong(int newIndex)
{
    this->activeSong = newIndex;
}

/*!
 * \brief playlist_handler::getPlaylists Get all of the playlists in the wrapper
 * \return A vector containing all playlists item
 */
std::vector<playlist> playlist_handler::getPlaylists()
{
    return this->playlists;
}

/*!
 * \brief playlist_handler::getPlaylist Get the playlist from the specified index
 * \return A playlist item
 */
playlist playlist_handler::getPlaylist(int index)
{
    return this->playlists[index];
}


/*!
 * \brief playlist_handler::getPlaylistNames Get a list containing all playlist names
 * \return A vector containing playlist names
 */
std::vector<QString> playlist_handler::getPlaylistNames()
{
    std::vector<QString> titles;
    for ( int index = 0 ; index < this->playlists.size() ; index++ )
    {
        titles.insert(titles.begin() + index, this->playlists[index].getPlaylistTitle());
    }
    return titles;
}

/*!
 * \brief playlist_handler::getPlaylistSongNames Get a vector containing the songs in the current playlist
 * \param playlistIndex The index of the playlist to get songs from
 * \return A vector containing song names
 */
std::vector<QString> playlist_handler::getPlaylistSongNames(int playlistIndex)
{
    playlist toCheck = this->playlists.at(playlistIndex);
    std::vector<QString> titles;
    for ( int index = 0 ; index < toCheck.getSongs().size() ; index++ )
    {
        titles.insert(titles.begin() + index, toCheck.getSongs()[index].getSongName());
    }
    return titles;
}

/*!
 * \brief playlist_handler::getActivePlaylist Get the current playlist being used
 * \return The active playlist
 */
playlist playlist_handler::getActivePlaylist()
{
    return this->playlists[this->activePlaylist];
}

/*!
 * \brief playlist_handler::getActivePlaylistIndex Get the index of the active playlist
 * \return An int indicating which playlist to use
 */
int playlist_handler::getActivePlaylistIndex()
{
    return this->activePlaylist;
}

/*!
 * \brief Get the hash of the song to be played.
 */
QString playlist_handler::getActiveSongHash()
{
    return this->playlists.at(this->activePlaylist).getSongs()[this->activeSong].getHash();
}

/*!
 * \brief playlist_handler::getShuffle Get the state of the shuffle function
 * \return A boolean indicator for the shuffle value
 */
bool playlist_handler::getShuffle()
{
    return this->shuffle;
}

/*!
 * \brief playlist_handler::getRepeat Get the state of the repeat function
 * \return A boolean indicator for the repeat value
 */
bool playlist_handler::getRepeat()
{
    return this->repeat;
}

/*!
 * \brief playlist_handler::setActivePlaylistIndex Change which playlist is playing
 * \param newIndex The index of the playlist to be used
 */
void playlist_handler::setActivePlaylistIndex(int newIndex)
{
    this->activePlaylist = newIndex;
}

/*!
 * \brief playlist_handler::setActiveSongIndex Change which song is playing
 * \param newIndex The index of the song to be set
 */
void playlist_handler::setActiveSongIndex(int newIndex)
{
    this->activeSong = newIndex;
}

/*!
 * \brief playlist_handler::setShuffle Set the shuffle function value
 * \param shuf A boolean indicator for the new set
 */
void playlist_handler::setShuffle(bool shuf)
{
    this->shuffle = shuf;
}

/*!
 * \brief playlist_handler::setRepeat Set the repeat function value
 * \param rep A boolean indicator for the new set
 */
void playlist_handler::setRepeat(bool rep)
{
    this->repeat = rep;
}

/*!
 * \brief playlist_handler::repeatSwitch Toggle the state of the repeat function
 */
void playlist_handler::repeatSwitch()
{
    if ( this->repeat )
    {
        this->repeat = false;
    }
    else
    {
        this->repeat = true;
    }

}

/*!
 * \brief playlist_handler::shuffleSwitch Toggle the state of the shuffle function
 */
void playlist_handler::shuffleSwitch()
{
    if (this->shuffle )
    {
        this->shuffle = false;
    }
    else
    {
        this->shuffle = true;
    }
}

/*!
 * \brief playlist_handler::changePlaylist Switch the active playlist to the specified playlist.
 * \param newIndex The index of the playlist to switch to
 */
void playlist_handler::changePlaylist(int newIndex)
{
    this->setActivePlaylistIndex(newIndex);
    this->setActiveSongIndex(0);
}

/*!
 * \brief playlist_handler::changePlaylist Switch the active playlist to the specified playlist.
 * \param playlistTitle The title of the playlist to switch to.
 */
void playlist_handler::changePlaylist(QString playlistTitle)
{
    for ( int index = 0 ; index < this->playlists.size() ; index++ )
    {
        if ( this->playlists[index].getPlaylistTitle() == playlistTitle)
        {
            this->changePlaylist(index);
            break;
        }
    }
}

void playlist_handler::changeTrackListings(int index)
{
    this->changePlaylist(index);
    QStringList dataList;

    for ( int i = 0; i < this->getActivePlaylist().getSongs().size() ; i++ )
    {
        qDebug() << "Song" << i << ":" << this->getActivePlaylist().getSongs().at(i).getSongName();
        dataList.append(this->getActivePlaylist().getSongs().at(i).getSongName());
        qDebug() << "DataList" << i << ":" << QVariant(dataList);
    }

    //qDebug() << "calling setTrackListings:" << QVariant::fromValue(dataList);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    QObject *root = engine.rootObjects().first();
    QObject *trackListings = root->findChild<QObject*>("trackListings");

    if (trackListings)
    {
        qDebug() << "BEFORE:" << trackListings->property("model");
        trackListings->setProperty("model", QVariant(dataList));
        qDebug() << "AFTER:" << trackListings->property("model");
        QObject *trackListings = root->findChild<QObject*>("trackListings");
        qDebug() << "GETTING:" << trackListings->property("model");
    }
    else
    {
        qDebug() << "trackListings has not yet been set";
    }

    //qDebug() << "cppModel: " << engine.rootContext()->contextProperty("cppModel");
    //engine.rootContext()->setContextProperty( "cppModel", QVariant::fromValue(dataList) );
    //QObject *trackListings = root->findChild<QObject*>("trackListings");
    //QMetaObject::invokeMethod(trackListings, "setTrackListings",
    //    Q_ARG(QVariant, QVariant::fromValue(dataList)));

}

