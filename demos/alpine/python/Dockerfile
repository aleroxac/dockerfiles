# syntax=docker/dockerfile:1
FROM aleroxac/python:v1.0.0-alpine as base



# ---------- BUILD
FROM base AS build
USER root
WORKDIR /build
COPY src/requirements.txt /build/requirements.txt
RUN pip install --no-cache-dir --prefix=/build -r /build/requirements.txt
USER python



# ---------- MAIN
FROM base AS main
USER root
WORKDIR /app

COPY --from=build /build /usr/local
COPY src/app.py /app
USER python

CMD [ "python" , "app.py" ]
EXPOSE 8000
HEALTHCHECK CMD ["wget", "-q", "localhost:8000/healthz"]
