#include "RestApiClient.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>
#include <QDebug>

namespace {
const QString k_endpointUrl = "http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks";
}

RestApiClient::RestApiClient(QObject *parent)
    : QObject{parent}
    , m_networkManager(new QNetworkAccessManager(this))
{

}

void RestApiClient::sendGetTasksRequest()
{
    QNetworkRequest request(k_endpointUrl);
    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            parseGetTasksResponse(reply->readAll());
        }
        reply->deleteLater();
    });
}

void RestApiClient::sendDeleteTaskRequest(const QString &id)
{
    QNetworkRequest request(QString("%1/%2").arg(k_endpointUrl, id));
    QNetworkReply *reply = m_networkManager->deleteResource(request);

    connect(reply, &QNetworkReply::finished, this, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            if (reply->attribute(QNetworkRequest::HttpStatusCodeAttribute) == 200) {
                emit taskRemoved(id);
            }
        }
        reply->deleteLater();
    });
}

void RestApiClient::sendPostTaskRequest(const QString &title)
{
    QNetworkRequest request(k_endpointUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QJsonDocument jsonBody(QJsonObject{{"task", title}});
    QNetworkReply *reply = m_networkManager->post(request, jsonBody.toJson());

    connect(reply, &QNetworkReply::finished, this, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            if (reply->attribute(QNetworkRequest::HttpStatusCodeAttribute) == 201) {
                this->sendGetTasksRequest();
            }
        }
        reply->deleteLater();
    });
}

void RestApiClient::parseGetTasksResponse(const QByteArray &response)
{
    const QJsonDocument &jsonResponse = QJsonDocument::fromJson(response);
    if (jsonResponse.isArray()) {
        auto results = jsonResponse.array().toVariantList();
        emit tasksReady(results);
    }
}
