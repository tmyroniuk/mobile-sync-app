#include "notificationserver.h"
#include <iostream>
#include <QByteArray>
#include <QSslCertificate>
#include <QSslKey>

using namespace std;

NotificationServer::NotificationServer(QObject* parent) : QTcpServer(parent){}


void NotificationServer::incomingConnection(int socketDescriptor)
{
    auto socket = new QSslSocket;
    connect(socket, SIGNAL(encrypted()),
            this, SLOT(startRead()));
    listen(QHostAddress::Any, 8889);
    if (socket->setSocketDescriptor(socketDescriptor))
    {
        QByteArray key;
        QByteArray cert;

        QFile file_key("/path_to_key/rsakey");

        if(file_key.open(QIODevice::ReadOnly))
        {
            key = file_key.readAll();
            file_key.close();
        }
        else
        {
            qDebug() << file_key.errorString();
        }

        QFile file_cert("/path_to_certificate/mycert.pem");
        if(file_cert.open(QIODevice::ReadOnly))
        {
            cert = file_cert.readAll();
            file_cert.close();
        }
        else
        {
            qDebug() << file_cert.errorString();
        }

        QSslKey ssl_key(key, QSsl::TlsV1_2);
        QSslCertificate ssl_cert(cert);

        socket->setPrivateKey(ssl_key);
        socket->setLocalCertificate(ssl_cert);

        QSslConfiguration cfg = socket->sslConfiguration();
        cfg.caCertificates();

        socket->startServerEncryption();
    }
}
