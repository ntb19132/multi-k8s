docker build -t ntb19132/multi-client:latest -t ntb19132/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ntb19132/multi-server:latest -t ntb19132/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ntb19132/multi-worker:latest -t ntb19132/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ntb19132/multi-client:latest
docker push ntb19132/multi-server:latest
docker push ntb19132/multi-worker:latest

docker push ntb19132/multi-client:$SHA
docker push ntb19132/multi-server:$SHA
docker push ntb19132/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment  server=ntb19132/multi-server:$SHA
kubectl set image deployments/client-deployment  client=ntb19132/multi-client:$SHA
kubectl set image deployments/worker-deployment  worker=ntb19132/multi-worker:$SHA