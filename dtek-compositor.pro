QT += gui qml

SOURCES += \
    main.cpp

OTHER_FILES = \
    qml/main.qml \

RESOURCES += dtek-compositor.qrc

target.path = /root/dtek-compositor

INSTALLS += target

DISTFILES += \
    qml/Chrome.qml \
    qml/ScreenOutput.qml
