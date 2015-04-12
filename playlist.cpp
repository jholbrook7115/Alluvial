#include "playlist.h"
#include <QObject>
#include <vector>
#include <QDebug>

playlist::playlist()
{
    this->name = "Untitled Playlist";
    this->songs = std::vector<playlist_item>();
    this->shuffle = false;
    this->repeat = false;
}

playlist::playlist(QString title)
{
    this->name = title;
    this->songs = std::vector<playlist_item>();
    this->shuffle = false;
    this->repeat = false;
}

playlist::~playlist()
{

}

/*!
 * \brief A function to relocate a song in the playlist
 * \param songToMove The song that is to be relocated
 * \param newPosition Where we want the song to end up in the playlist
*/
void playlist::moveSong(playlist_item songToMove, int newPosition)
{
    QString deleteSongHash = songToMove.getHash();
    for ( int index = 0; index < this->songs.size() ; index++ )
    {
        if ( this->songs[index].getHash() == deleteSongHash )
        {
            this->songs.erase(this->songs.begin() + index);
            break;
        }
    }
    this->songs.insert(this->songs.begin() + newPosition, songToMove);
}

/*!
 * \brief playlist::addSong Add a song to the start of the playlist
 * \param newSong The song to be added
 */
void playlist::addSong(playlist_item newSong)
{
    this->songs.insert(this->songs.begin(), newSong);
}

/*!
 * \brief playlist::removeSong Used to remove a song from the playlist
 * \param deleteSong The song to be deleted from the playlist
 */
void playlist::removeSong(playlist_item deleteSong)
{
    QString deleteSongHash = deleteSong.getHash();
    for ( int index = 0; index < this->songs.size() ; index++ )
    {
        if ( this->songs[index].getHash() == deleteSongHash )
        {
            this->songs.erase(this->songs.begin() + index);
            break;
        }
    }
}

/*!
 * \brief playlist::getSongHash Get the hash of a song by its index
 * \param songIndex The index of the song to be gotten
 */
QString playlist::getSongHash(int songIndex)
{
    return this->songs[songIndex].getHash();
}

/*!
 * \brief playlist::getPlaylistTitle Get the title of the playlist
 * \return QString containing playlist title
 */
QString playlist::getPlaylistTitle()
{
    return this->name;
}

/*!
 * \brief playlist::getSongs Get the vector containing all songs
 * \return Vector containing the songs
 */
std::vector<playlist_item> playlist::getSongs()
{
    return this->songs;
}






