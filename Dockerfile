# ----------- Stage: Build ----------- #
FROM gcc:13 AS build

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    cmake \
    gcc \
    g++ \
    build-essential

WORKDIR /app

COPY . .

RUN python3 -m venv /app/myenv

# Fix: 'pip install --upgrade pip' (not --update)
RUN /app/myenv/bin/pip install --upgrade pip && \
    /app/myenv/bin/pip install conan

RUN /app/myenv/bin/conan profile detect --force && \
    /app/myenv/bin/conan install . --build=missing

# Fix: typo in 'Unix Makefiles' and toolchain file path spacing
RUN cmake -G "Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE=build/Release/generators/conan_toolchain.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -B build/Release -S .

RUN cmake --build build/Release

# ----------- Stage: Runtime ----------- #
FROM ubuntu:22.04 AS runtime

WORKDIR /app

# Copy only the final built binary
COPY --from=build /app/build/Release/firmware /app/firmware

# Set default command
CMD ["./firmware"]
