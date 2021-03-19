call 99-apply-patches.bat
call 00-build-source
call docker build --no-cache -t postgres-master-vanilla-run ./011-base
