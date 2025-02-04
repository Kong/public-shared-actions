# Use the specified base image for Semgrep
ARG BASE_TOOL_IMAGE
ARG BASE_IMAGE

FROM $BASE_IMAGE AS semgrep

RUN addgroup -g 1001 kong && \
    adduser -D -u 1001 -G kong kong

# Switch to the non-root user
USER kong

ENTRYPOINT ["semgrep"]
