docker build -t saardagan/multi-client:latest -t saardagan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saardagan/multi-server:latest -t saardagan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saardagan/multi-worker:latest -t saardagan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saardagan/multi-client:latest
docker push saardagan/multi-server:latest
docker push saardagan/multi-worker:latest

docker push saardagan/multi-client:$SHA
docker push saardagan/multi-server:$SHA
docker push saardagan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saardagan/multi-server:$SHA
kubectl set image deployments/client-deployment client=saardagan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saardagan/multi-worker:$SHA