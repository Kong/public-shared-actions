# ARGs for external input (These should be set during build)
ARG BASE_TOOL_IMAGE
ARG BASE_IMAGE

# Stage 1: Use aquasec/trivy as the base
FROM $BASE_TOOL_IMAGE AS trivy-setup

# Create a writable cache directory for the non-root user
RUN mkdir -p /home/1001/.cache/trivy && chown -R 1001:0 /home/1001/.cache

# Stage 2: Final minimal image (distroless) with Trivy
FROM $BASE_IMAGE AS trivy-final

### Copy the Trivy binary from the setup stage
COPY --from=trivy-setup --chown=1001:0 /usr/local/bin/trivy /usr/local/bin/trivy
COPY --from=trivy-setup --chown=1001:0 /home/1001/.cache /home/1001/.cache

# Set environment variable for Trivy DB cache path
ENV TRIVY_CACHE_DIR="/home/1001/.cache/trivy"

# Run Trivy as Non-root user
USER 1001

# Set the entrypoint to Trivy without shell access
ENTRYPOINT ["/usr/local/bin/trivy"]