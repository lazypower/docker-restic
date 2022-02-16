# Restic Sidecar

Restic in a can, useful in backing up persistent volumes in K8s deployments.

This is not something I wish to do manually, so the the theory is to hook into a crond in the container,
and render files to both execute the backup and automate checking of the repository.

By default we trim to 7 versions available.


## Usage

- Set environment variables for container as follows:
    - BACKUP_SOURCE: folder to be backed up (defaults to /data)
    - RESTIC_REPOSITORY: folder for restic repository (backup storage location, defaults to /repo)
    - RESTIC_PASSWORD: password for restic repository
    - BACKUP_CRON: cron expression for backup timing (defaults to 00 */24 * * *)
    - CHECK_CRON: cron expression for backup integrity checks (defaults to 00 04 * * 1)
    - RESTIC_FORGET_ARGS: arguments for restic forget command (defaults to --keep-last 7)
        - if set to "", no restic forget command is ever run
    - NICE_ADJUST: nice priority adjustment, defaults to 10 for ~50% CPU time of normal-priority process
    - IONICE_CLASS: ionice scheduling class, defaults to 2 for best-effort IO
    - IONICE_PRIO: ionice priority, defaults to 7 for lowest priority IO
        - ionice is used for `restic backup`, `restic forget` and `restic check` commands
- Occasionally check container logs to see backup results

