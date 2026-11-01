add_library(BreakSilence.Assets STATIC)

qt_add_resources(BreakSilence.Assets
    URI "BreakSilence.Assets"
    PREFIX "/assets"
    FILES
        folder.svg
        breaksilence_dark.svg
        breaksilence_paused_dark.svg
        breaksilence_played_dark.svg
        breaksilence_light.svg
        breaksilence_paused_light.svg
        breaksilence_played_light.svg
        question_mark-svgrepo_com.svg
)