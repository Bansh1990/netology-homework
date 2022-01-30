import sentry_sdk
sentry_sdk.init(
    "https://f96bb96f4a5f4f94a9c2e63d096c4d70@o1130612.ingest.sentry.io/6174712",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0
)

division_by_zero = 1 / 0