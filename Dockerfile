FROM alpine:latest

RUN apk add --no-cache \
	openssh \
	tzdata \
	curl \
	ca-certificates \
	rsync && \
	rm -rf /var/cache/apk/*

COPY entrypoint.sh /
COPY add-auth-key /usr/local/bin/

RUN chmod u+x /entrypoint.sh && \
	chmod u+x /usr/local/bin/add-auth-key

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh"]
