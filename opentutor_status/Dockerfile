FROM python:3.8-slim
WORKDIR /tmp
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt && rm requirements.txt
WORKDIR /app
RUN rm -rf /tmp/build
ENV FLASK_APP=opentutor_status
WORKDIR /app
COPY src .
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]