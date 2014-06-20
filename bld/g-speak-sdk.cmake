
# /* (c) 2012 Oblong Industries */

# find various yobuilds and nobuilds
if (UNIX)
  set (G_SPEAK_DEPS "/opt/oblong/deps")
  set (CMAKE_FIND_ROOT_PATH "${CMAKE_FIND_ROOT_PATH} ${G_SPEAK_DEPS}")
endif ()

if (NOT G_SPEAK_MIN_VERSION)
  set (G_SPEAK_MIN_VERSION "3.10")
endif ()

set (G_SPEAK_HOME $ENV{G_SPEAK_HOME}) # blork, $ENV isn't testable.
if (NOT G_SPEAK_HOME)
  execute_process(
    COMMAND ${mct_SOURCE_DIR}/bld/find-gspeak-sdk ${G_SPEAK_MIN_VERSION}
    OUTPUT_VARIABLE G_SPEAK_HOME
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
endif()

if (NOT G_SPEAK_HOME)
  set (msg "Can't find g-speak >= ${G_SPEAK_MIN_VERSION}, please set the")
  set (msg "${msg} G_SPEAK_HOME environment variable")
  message (FATAL_ERROR "\n${msg}\n")
endif ()

if (EXISTS ${G_SPEAK_HOME} AND IS_DIRECTORY ${G_SPEAK_HOME})
  message (STATUS "found g-speak: ${G_SPEAK_HOME}")
else ()
  set (msg "I thought I found g-speak at ${G_SPEAK_HOME}, but it's not")
  set (msg "${msg} even a directory")
  message (FATAL_ERROR "\n${msg}\n")
endif ()

if (APPLE)
  set (PKG_CONFIG_EXECUTABLE ${G_SPEAK_DEPS}/bin/pkg-config)
else ()
  set (PKG_CONFIG_EXECUTABLE pkg-config)
endif ()
set (ENV{PKG_CONFIG_PATH} "ENV{PKG_CONFIG_PATH}:${G_SPEAK_HOME}/lib/pkgconfig")
