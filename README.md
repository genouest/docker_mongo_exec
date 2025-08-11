# mongo_exec

Custom Docker image to be used with [BEAURIS](https://gitlab.com/beaur1s/beauris)

Will create a custom user, run mongo as that user, store the PID as an env variable (to stop it from the other process), and run a user command.

If no user command is provided, it will simply launch mongo in the foreground.

You can pass the DATA_DIR variable. It will the content of the folder will be copied into /data/db before running mongo (to avoid permission issues later)