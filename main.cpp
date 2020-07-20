#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>

#include"todomodelmain.h"
#include"checklistmodelsub.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    ToDoModelMain mainModel;
    CheckListModelSub checkModel;

    QQmlApplicationEngine engine;
    QQmlContext *context1 = engine.rootContext();
    QQmlContext *context2 = engine.rootContext();

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    context1->setContextProperty("todomodelMain",&mainModel);
    context2->setContextProperty("todomodelCheck",&checkModel);

    engine.load(url);

    return app.exec();
}
