#include "qaterialplugin.h"

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

}
