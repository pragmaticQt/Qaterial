#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "Qaterial/Logger.hpp"

int main(int argc, char *argv[]) {
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qaterial::Logger::logger().info("C++: Logger ready!");

    // Add import search path
    engine.addImportPath(QCoreApplication::applicationDirPath()+"/..");

    qaterial::Logger::logger().debug("C++: engine addImportPath!");

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
