#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "processes_queue_model.h"
#include "scheduler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    qmlRegisterType<ProcessesQueueModel>("scheduler", 0, 1, "ProcessesQueueModel");
    qmlRegisterType<Scheduler>("scheduler", 0, 1, "Scheduler");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
