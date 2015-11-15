FROM python:2.7

RUN adduser --system --no-create-home --disabled-password --disabled-login newrelic && \
    mkdir -p /var/log/newrelic /var/run/newrelic /opt/newrelic-plugin-agent && \
    chown newrelic /var/log/newrelic /var/run/newrelic /opt/newrelic-plugin-agent

COPY . /usr/src/app
RUN cd /usr/src/app && \
    pip install -e .[mongodb,pgbouncer,postgresql]

VOLUME [ "/etc/newrelic/" ]
WORKDIR /opt/newrelic-plugin-agent
USER newrelic
ENTRYPOINT [ "/usr/local/bin/newrelic-plugin-agent" ]
CMD [ "-f", "-c", "/etc/newrelic/newrelic-plugin-agent.cfg" ]
