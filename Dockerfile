FROM python:3.12.0-bookworm
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN adduser bmc && \
	mkdir /config /pbmc && \ 
	chown bmc:bmc /config /pbmc && \
	chmod 755 /docker-entrypoint.sh
	

USER bmc

WORKDIR /pbmc
RUN git clone https://github.com/jb606/proxmoxbmc.git -b pbmcd-cmd-line-args
RUN python3 -m venv . &&\
	. .env/bin/activate &&\
	pip install -U pip setuptools && \
	pip install -r requirements.txt && \
	python -m setup install

ENV PATH="/pbmc/bin:${PATH}"
VOLUME [ "/config"]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
