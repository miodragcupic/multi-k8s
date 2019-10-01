docker build -t miodragcdocker/multi-client:latest -t miodragcdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t miodragcdocker/multi-server:latest -t miodragcdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t miodragcdocker/multi-worker:worker -t miodragcdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push miodragcdocker/multi-client:latest
docker push miodragcdocker/multi-server:latest
docker push miodragcdocker/multi-worker:latest

docker push miodragcdocker/multi-client:$SHA
docker push miodragcdocker/multi-server:$SHA
docker push miodragcdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=miodragcdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=miodragcdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=miodragcdocker/multi-worker:$SHA
