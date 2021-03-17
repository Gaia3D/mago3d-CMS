FROM gaia3d/mago3d-converter

# nginx repo 추가
COPY nginx.repo /etc/yum.repos.d/nginx.repo

RUN \
    yum install -y vim wget unzip && yum repolist && \
    yum install -y nginx && \
    # nodejs 14.x 버전
    curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    yum install -y nodejs && \
    # mago3djs 최신 버전 clone
    cd /tmp && git clone -b feature/v3.0 --single-branch https://github.com/Gaia3D/mago3djs.git && \
    # mago3djs build
    cd mago3djs/ && npm install && npm run build && \
    # 빌드된 js 를 nginx 경로로 복사
    mkdir -p /usr/share/nginx/html/js && cp -R build/mago3d /usr/share/nginx/html/js/ && cp -R src/engine/cesium/ /usr/share/nginx/html/js/ && \
    # clean
    rm -rf /tmp/* && yum clean all && rm -rf /var/cache/yum/*

# nginx background 실행
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

CMD ["/sbin/init"]