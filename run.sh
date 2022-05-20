source ./.env
docker-compose up -d
docker-compose run drkiq rake db:migrate
docker-compose up -d