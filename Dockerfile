FROM python:3.12.0-bookworm AS build

RUN git clone https://github.com/jb606/proxmoxbmc.git -b pbmcd-cmd-line-args
WORKDIR /proxmoxbmc
RUN python3 -m venv /pbmc &&\
	. /pbmc/bin/activate &&\
	pip install -U pip setuptools && \
	pip install -r requirements.txt && \
	python -m setup install


FROM python:3.12.0-bookworm

COPY --from=build /pbmc /pbmc
COPY files/docker-entrypoint.sh /docker-entrypoint.sh
RUN adduser bmc && \
	mkdir /config && \ 
	chown bmc:bmc /config /pbmc && \
	chmod 755 /docker-entrypoint.sh
	

USER bmc
ENV PATH="/pbmc/bin:${PATH}"


VOLUME [ "/config"]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
