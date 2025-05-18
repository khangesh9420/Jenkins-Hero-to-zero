FROM gcc:13

RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv cmake build-essential wget unzip

RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install --upgrade pip conan

# Install SonarQube Scanner CLI
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip \
    && unzip sonar-scanner-cli-5.0.1.3006-linux.zip -d /opt \
    && ln -s /opt/sonar-scanner-5.0.1.3006-linux/bin/sonar-scanner /usr/bin/sonar-scanner \
    && rm sonar-scanner-cli-5.0.1.3006-linux.zip

ENV PATH="/opt/venv/bin:/opt/sonar-scanner-5.0.1.3006-linux/bin:$PATH"

WORKDIR /app

CMD ["/bin/bash"]
