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
TRANSLATIONS += \
    translations/harbour-papocchio-cs.ts \
    translations/harbour-papocchio-de.ts \
    translations/harbour-papocchio-el.ts \
    translations/harbour-papocchio-hu.ts \
    translations/harbour-papocchio-it.ts \
    translations/harbour-papocchio-nb_NO.ts \
    translations/harbour-papocchio-nl.ts \
    translations/harbour-papocchio-ru_RU.ts \
    translations/harbour-papocchio-sr.ts \
    translations/harbour-papocchio-sv.ts
