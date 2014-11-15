TARGET = harbour-papocchio

CONFIG += sailfishapp

SOURCES += \
    src/main.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    translations/*.ts \
    qml/pages/MainPage.qml \
    qml/Papocchio.qml \
    harbour-papocchio.desktop \
    rpm/harbour-papocchio.changes \
    rpm/harbour-papocchio.spec \
    rpm/harbour-papocchio.yaml

CONFIG += sailfishapp_i18n
