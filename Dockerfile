FROM gcc:13

RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv cmake build-essential

RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install --upgrade pip conan

ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app

# No code copied or built here — build happens at runtime in Jenkins

CMD ["/bin/bash"]
