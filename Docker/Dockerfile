# Install pyrax and ansible-base
FROM alpine:3.9 as pyrax-image

RUN apk add --update --no-cache --virtual build-dependencies \
    build-base \
    python3-dev \
    linux-headers \
    libffi-dev \
    openssl-dev \
    gcc \
  && pip3 install --no-cache-dir --user --upgrade pyrax

# Alpine 3.9 191 MB
FROM alpine:3.9

RUN apk add --no-cache ansible
COPY --from=pyrax-image /root/.local /root/.local
COPY entrypoint.sh /entrypoint.sh
COPY ansible/ /ansible
ENV PYTHONPATH "${PYTONPATH}:/root/.local/lib/python3.6/site-packages"
CMD ["ansible-playbook" "--version"]

ENTRYPOINT ["/entrypoint.sh"]
