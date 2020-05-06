docker image 다운로드
    - docker image pull gaia3d/mago3d-postgresql:12
docker container 실행
    - docker container run --privileged --restart=always -d -p 15432:5432  --name "mago3d-postgresql" gaia3d/mago3d-postgresql:12 /sbin/init

