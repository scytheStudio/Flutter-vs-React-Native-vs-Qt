#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "RestApiClient.h"
#include "TasksModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/QtToDoList/main.qml"_qs);

    RestApiClient restApiClient;
    TasksModel tasksModel;

    QObject::connect(&restApiClient, &RestApiClient::tasksReady, &tasksModel, &TasksModel::synchronize);
    QObject::connect(&restApiClient, &RestApiClient::taskRemoved, &tasksModel, &TasksModel::onTaskRemoved);

    engine.rootContext()->setContextProperty("restApiClient", &restApiClient);
    engine.rootContext()->setContextProperty("tasksModel", &tasksModel);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
