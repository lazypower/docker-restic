FROM restic/restic@sha256:3d8655b111a584fb649eabe4c69c61abbef93505348acdcd557d974c54a07249

RUN apk add --no-cache dumb-init

ADD backup.sh /
ADD check.sh /
ADD entry.sh /

ENV RESTIC_REPOSITORY "/repo"
ENV RESTIC_PASSWORD ""
ENV BACKUP_CRON "00 */24 * * *"
ENV CHECK_CRON "00 04 * * 1"
ENV BACKUP_SOURCE "/data"
ENV RESTIC_FORGET_ARGS "--keep-last 7"
ENV NICE_ADJUST "10"
ENV IONICE_CLASS "2"
ENV IONICE_PRIO "7"

ENTRYPOINT ["dumb-init", "/entry.sh"]


CMD ["tail", "-fn0", "/var/log/cron.log"]
