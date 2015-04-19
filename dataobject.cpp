#include "dataobject.h"
#include <QDebug>

DataObject::DataObject( QObject * parent )
    : QObject( parent )
{
    qDebug() << "DataObject::DataObject() has been called.\n";

}

DataObject::DataObject( const QString &_name, QObject * parent )
    : QObject( parent )
    , m_name( _name )
{
    qDebug() << "DataObject::DataObject(name) has been called.\n";

}


QString DataObject::name() const {
    qDebug() << "name() has been called.\n";
    return m_name;
}

void DataObject::setName(const QString &name) {
    qDebug() << "setName has been called.\n";
    if ( name != m_name ) {
        m_name = name;
        emit nameChanged();
    }
}
