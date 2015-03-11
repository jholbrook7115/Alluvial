#ifndef SETTINGS_STORAGE
#define SETTINGS_STORAGE

#include <QObject>
#include <QSettings>
#include <iostream>
#include <fstream>
#include <QFile>
#include <QCoreApplication>


class Settings_storing:public QSettings{
    Q_OBJECT
    /*
    Q_PROPERTY(QString value READ getData WRITE saveData NOTIFY valueChanged)
public:
    explicit Settings(QObject *parent=0);
    Q_INVOKABLE void saveData(const QString & key, const QVariant & value);
    Q_INVOKABLE QVariant getData();
signals:
public slots:
private:
    QObject client_settings;
*/
    public:
        explicit Settings_storing(QObject*parent=0): QSettings(QSettings::IniFormat, QSettings::UserScope,
                                                       QCoreApplication::instance()->organizationName(),
                                                       QCoreApplication::instance()->applicationName(),
                                                       parent){}
        Q_INVOKABLE void setValue(const QString & key, const QVariant & value){ QSettings::setValue(key, value);}
        Q_INVOKABLE QVariant value(const QString &key, const QVariant & defaultValue = QVariant()) const {
            return QSettings::value(key, defaultValue);
        }
    signals:
    public slots:
    private:
        QSettings client_settings;
};

Q_DECLARE_METATYPE(Settings_storing*)

#endif // SETTINGS_STORAGE


