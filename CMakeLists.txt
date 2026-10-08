cmake_minimum_required(VERSION 3.16)

project(BreakSilence VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

add_subdirectory(metaObjects)
add_subdirectory(source)

target_link_libraries(BreakSilence.APP
    PRIVATE
        Qt6::Quick
        BreakSilence.MetaObjects
)

install(TARGETS BreakSilence.APP
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
