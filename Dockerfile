docker create \
  --privileged \
  --name gcsfuse-docker \
  --volume ${{ github.workspace }}/gcloud:/etc/gcloud \
  --volume ${{ github.workspace }}/mnt:/mnt \
  --tty \
  levkuznetsov/gcsfuse-docker \
  sleep inf
docker start gcsfuse-docker
docker exec gcsfuse-docker apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6A030B21BA07F4FB 8B57C5C2836F4BEB
docker exec gcsfuse-docker apt-get update
docker exec gcsfuse-docker apt-get dist-upgrade -y --allow-unauthenticated
docker exec gcsfuse-docker gcsfuse --implicit-dirs -o allow_other ${{ secrets.APT_GCS_BUCKET_NAME }} /mnt
