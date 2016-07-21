TARGET = harbour-papocchio

CONFIG += sailfishapp

SOURCES += \
    src/main.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/MainPage.qml \
    qml/Papocchio.qml \
    harbour-papocchio.desktop \
    rpm/harbour-papocchio.changes \
    rpm/harbour-papocchio.spec \
    rpm/harbour-papocchio.yaml
    translations/*.ts

CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-papocchio-cs.ts \
    translations/harbour-papocchio-it.ts \
    translations/harbour-papocchio-nl.ts \
    translations/harbour-papocchio-sr.ts
