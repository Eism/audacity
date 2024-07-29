set(SENTRY_URL "" CACHE STRING "Sentry URL")
set(SENTRY_AUTH_TOKEN "" CACHE STRING "Sentry Auth Token")
set(SENTRY_ORG "" CACHE STRING "Sentry Organization")
set(SENTRY_PROJECT "" CACHE STRING "Sentry Project")

set(CONFIG
    -DSENTRY_URL=${SENTRY_URL}
    -DSENTRY_ORG=${SENTRY_ORG}
    -DSENTRY_AUTH_TOKEN=${SENTRY_AUTH_TOKEN}
    -DSENTRY_PROJECT=${SENTRY_PROJECT}
)

set(LOCAL_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR}/_deps)

execute_process(
    COMMAND cmake ${CONFIG} -P ${LOCAL_ROOT_PATH}/ci_sentry_dumpsyms_upload.cmake
)
