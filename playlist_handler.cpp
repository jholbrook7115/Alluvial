#include "playlist_handler.h"
#include "playlist.h"
#include <vector>
#include <QDebug>

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

void playlist_handler::addPlaylist()
{
    playlist *newPlaylist = new playlist();
    this->playlists.insert(this->playlists.begin(), *newPlaylist);
}

void playlist_handler::addPlaylist(playlist newPlaylist)
{
    this->playlists.insert(this->playlists.begin(), newPlaylist);
}

void playlist_handler::addPlaylist(QString playlistTitle)
{
    playlist *newPlaylist = new playlist(playlistTitle);
    this->playlists.insert(this->playlists.begin(), *newPlaylist);
}

void playlist_handler::dropPlaylists()
{
    this->playlists.erase(this->playlists.begin(),this->playlists.end());
}

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

std::vector<playlist> playlist_handler::getPlaylists()
{
    return this->playlists;
}

std::vector<QString> playlist_handler::getPlaylistNames()
{
    std::vector<QString> titles;
    for ( int index = 0 ; index < this->playlists.size() ; index++ )
    {
        titles.insert(titles.begin() + index, this->playlists[index].getPlaylistTitle());
    }
    return titles;
}

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

playlist playlist_handler::getActivePlaylist()
{
    return this->playlists[this->activePlaylist];
}

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

bool playlist_handler::getShuffle()
{
    return this->shuffle;
}

bool playlist_handler::getRepeat()
{
    return this->repeat;
}

void playlist_handler::setActivePlaylistIndex(int newIndex)
{
    this->activePlaylist = newIndex;
}

void playlist_handler::setActiveSongIndex(int newIndex)
{
    this->activeSong = newIndex;
}

void playlist_handler::setShuffle(bool shuf)
{
    this->shuffle = shuf;
}

void playlist_handler::setRepeat(bool rep)
{
    this->repeat = rep;
}

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

void playlist_handler::changePlaylist(int newIndex)
{
    this->setActivePlaylistIndex(newIndex);
    this->setActiveSongIndex(0);
}

void playlist_handler::changePlaylist(QString playlistTitle)
{
    for ( int index = 0 ; index < this->playlists.size() ; index++ )
    {
        if ( this->playlists[index].getPlaylistTitle() == playlistTitle)
        {
            this->activePlaylist = index;
            break;
        }
    }
}
