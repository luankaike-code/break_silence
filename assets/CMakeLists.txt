add_library(BreakSilence.Assets STATIC)

qt_add_resources(BreakSilence.Assets
    URI "BreakSilence.Assets"
    PREFIX "/assets"
    FILES
        folder.svg
        breaksilence_icon.svg
)