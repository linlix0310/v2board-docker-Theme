#1、安装docker环境
curl -sSL https://get.docker.com/ | sh 
systemctl start docker 
systemctl enable docker

#2、安装docker-compose
apt-get install docker-compose -y
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#3、安装v2board
apt-get install git

git clone https://github.com/linlix0310/v2board-docker-Theme.git
git clone https://github.com/BobCoderS9/Bob-Theme-Argon.git
git clone https://github.com/v2board/v2board-docker.git
mv v2board-docker v2b

rm -rf v2b/caddy.conf
rm -rf v2b/docker-compose.yaml

mv v2board-docker-Theme/caddy.conf v2b/
mv v2board-docker-Theme/docker-compose.yaml v2b/


#4、配置稳定版v2board
cd v2b/
git submodule update --init
echo '  branch = master' >> .gitmodules
git submodule update --remote

mv ../Bob-Theme-Argon www/public/theme/

#5、启动docker
docker-compose up -d


#6、进入容器
docker-compose exec www bash &


#7、配置环境以及安装
wget https://getcomposer.org/download/1.9.0/composer.phar &
php composer.phar global require hirak/prestissimo &
php -d memory_limit=-1 composer.phar install &
php artisan v2board:install

#to do 输入数据库等信息

