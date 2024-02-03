docker build -t dobartos/multi-client:latest -t dobartos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dobartos/multi-server:latest -t dobartos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dobartos/multi-worker:latest -t dobartos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dobartos/multi-client:latest
docker push dobartos/multi-server:latest
docker push dobartos/multi-worker:latest

docker push dobartos/multi-client:$SHA
docker push dobartos/multi-server:$SHA
docker push dobartos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dobartos/multi-client:$SHA
kubectl set image deployments/server-deployment server=dobartos/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dobartos/multi-worker:$SHA
