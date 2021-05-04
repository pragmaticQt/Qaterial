#include "qaterialplugin.h"

#include <spdlog/sinks/stdout_color_sinks.h>

#include "Qaterial/IconDescription.hpp"
#include "Qaterial/IconLabelImpl.hpp"
#include "Qaterial/IconLabelPositionner.hpp"

#include "Qaterial/ColorTheme.hpp"
#include "Qaterial/TextTheme.hpp"
#include "Qaterial/Theme.hpp"

#include "Qaterial/Layout.hpp"

#include "Qaterial/Clipboard.hpp"
#include "Qaterial/Version.hpp"
#include "Qaterial/TextFile.hpp"
#include "Qaterial/Logger.hpp"

#include <QDir>
#include <QFontDatabase>
#include <QtDebug>

//#include "Qaterial/Utils.hpp"

void __Qaterial_registerIconsSingleton();//auto generate

void QaterialPlugin::registerTypes(const char* uri) {

    Q_ASSERT(uri == QLatin1String("Qaterial"));

    qaterial::IconDescription      ::registerToQml();
    qaterial::IconLabelImpl        ::registerToQml();
    qaterial::IconLabelPositionner ::registerToQml();

    qaterial::ColorTheme           ::registerToQml();
    qaterial::TextTheme            ::registerToQml();
    qaterial::Theme                ::registerToQml();

    qaterial::Layout               ::registerToQml();
    qaterial::TextFile             ::registerToQml();

    qaterial::Clipboard            ::registerSingleton();
    qaterial::Version              ::registerSingleton();
    qaterial::Logger               ::registerSingleton();

    __Qaterial_registerIconsSingleton();
}

static void Qaterial_loadFonts()
{
    const auto loadFont = [](const QString& fontFolderPath)
    {
        const QDir dir(fontFolderPath);
        for(const auto& file: dir.entryList(QDir::Files))
        {
            const auto fileUrl = fontFolderPath + "/" + file;
            if(QFontDatabase::addApplicationFont(fileUrl) >= 0)
                qInfo() << "Load font" << fileUrl.toStdString().c_str();
            else
                qCritical() << "Fail to load font" << fileUrl.toStdString().c_str();
        }
    };

    const QDir fontsDirectory(":/Qaterial/Fonts");
    for(const auto& fontDir: fontsDirectory.entryList(QDir::Dirs | QDir::NoDotAndDotDot))
    {
        const auto fontDirPath = fontsDirectory.path() + "/" + fontDir;
        loadFont(fontDirPath);
    }
}
static void initFonts() {
    Q_INIT_RESOURCE(QaterialFonts);
    Qaterial_loadFonts();
}

static void initIcons() {
    Q_INIT_RESOURCE(QaterialIcons);
}

static void initResources() {
    initFonts();
    initIcons();
}

static void registerCoutSink()
{
    // Create a stdout sink
    const auto stdoutSink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    // Redirect qaterial to stdout
    qaterial::Logger::registerSink(stdoutSink);

    // optionnal: Enable debug level
    stdoutSink->set_level(spdlog::level::debug);
    qaterial::Logger::QATERIAL->set_level(spdlog::level::debug);
}

#ifndef QATERIAL_STATIC
Q_COREAPP_STARTUP_FUNCTION(registerCoutSink)
Q_COREAPP_STARTUP_FUNCTION(initResources)
#endif
