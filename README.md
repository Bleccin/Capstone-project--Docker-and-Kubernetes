# Capstone-project--Docker-and-Kubernetes
The aim of this project is to develop a microservices-based weather application. The implementation involves creating two microservices: one for fetching weather data and another for displaying it. The primary objective include containerizing these microservices using Docker, deploying them to a kubernetes cluster, and accessing them through Nginx.

Project steps
    Initializing the application on git
1. Created a project directory named "docker-kubernetes-project."
2. I initialized a git repository in the directory using the "git init" command.
3. I added the HTML and CSS file for the weather app into the directory and added them to git using 'git add" command.
4. I  commited the files using "git commit - "Initial commit with HTML and CSS files"" command.

      Dockerizing the application
5. I created a docker file  using Nginx as the base image.
6. I copied the HTML anf CSS  file into the Nginx HTML directory from within the dockerfile. Below is the the content of the file.
   
   # Using Nginx base image
FROM nginx
# Run the HTML file
RUN rm -rf /usr/share/nginx/html/*
# Copy the HTML and CSS files to the Nginx web server directory
COPY index.html /usr/share/nginx/html
COPY styles.css /usr/share/nginx/html

7. I built an image for the dockerfile using the "docker build -t static-website ." command.
8. I ran a container from the image I just built on port 8080:80 using the "docker run -d -p 8080:80 static-website" command.
9. I tested the container to see that it's running by using the "curl http://localhost:8080" command and I was able to see my HTML code.
10. I logined into docker from the VM using "docker login", I taged the image using "docker tag static-website bleccin/static-website:latest" command.
11.  Finally I pushed the image into the docker hub using "docker push bleccin/static-website:latest" command.

    Deploy the application on Kubernetes
12. I installed "kIND" KUBERNETES IN DOCKER USING "curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind" comands.
13. I created a cluster using "kind create cluster"
14. I created a Deployment.yaml file and added below configurration to it.
    apiVersion: apps/v1
kind: Deployment
metadata:
  name: static-website-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: static-website
  template:
    metadata:
      labels:
        app: static-website
    spec:
      containers:
      - name: static-website
        image: bleccin/static-website:latest
        ports:
        - containerPort: 80
       
15. I applied the deployment using "kubectl apply -f deployment.yaml" command

      Creating a Service (ClusterIP)
16. I created a service.yaml file for the clusterIP service and added below configuration to it.

apiVersion: v1
kind: Service
metadata:
  name: static-website-service
spec:
  selector:
    app: static-website
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP

17. I applied the service using "kubectl apply -f service.yaml" command.

    Accessing the Application
18. I forwardes the service/static-website-service to 8000:80 using the "kubectl port-forward service/static-website-service 8000:80" command.
19. I was able to confirm that the app is runing in the browser on http://localhost:8000. 



