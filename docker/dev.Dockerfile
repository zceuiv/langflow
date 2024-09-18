FROM python:3.12-bookworm
ENV TZ=UTC

WORKDIR /app

RUN cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak
RUN sed -i 's@deb.debian.org@mirrors.cloud.tencent.com@g' /etc/apt/sources.list.d/debian.sources

RUN apt update -y
RUN apt install \
    build-essential \
    curl \
    npm \
    -y

COPY . /app

RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry lock --no-update
RUN poetry install --no-interaction --no-ansi

EXPOSE 7860
EXPOSE 3000

CMD ["./docker/dev.start.sh"]
# docker build -f docker/dev.Dockerfile -t langflow-dev:latest --network host .
