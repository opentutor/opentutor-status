FROM python:3.8-slim
ADD opentutor_status/requirements.txt opentutor_status/requirements.txt
RUN cd opentutor_status && pip install -r requirements.txt
WORKDIR /app
RUN rm -rf /tmp/build
ENV FLASK_APP=opentutor_status
WORKDIR /app
COPY opentutor_status/src .
RUN python -m nltk.downloader punkt \
	&& python -m nltk.downloader wordnet \
	&& python -m nltk.downloader averaged_perceptron_tagger \
	&& python -m nltk.downloader stopwords
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]