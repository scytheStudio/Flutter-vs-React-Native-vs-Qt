#ifndef RESTAPICLIENT_H
#define RESTAPICLIENT_H

#include <QObject>
#include <QNetworkAccessManager>

class RestApiClient : public QObject
{
    Q_OBJECT
public:
    explicit RestApiClient(QObject *parent = nullptr);

public slots:
    void sendGetTasksRequest();
    void sendDeleteTaskRequest(const QString &id);
    void sendPostTaskRequest(const QString &title);

signals:
    void tasksReady(const QVariantList &tasks);
    void taskRemoved(const QString &id);

private slots:
    void parseGetTasksResponse(const QByteArray &response);

private:
    QNetworkAccessManager *m_networkManager = nullptr;
};

#endif // RESTAPICLIENT_H
