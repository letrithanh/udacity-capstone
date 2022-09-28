#!/bin/bash

cat << EOF > ./deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: uda-capstone
spec:
    replicas: 1
    selector:
        matchLabels:
            app: uda-capstone
    template:
        metadata:
            labels:
                app: uda-capstone
        spec:
            containers:
            - name: uda-capstone
            image: $1
            ports:
            - containerPort: 3000

---

apiVersion: v1
kind: Service
metadata:
    name: udacaps-svc
spec:
    type: NodePort
    ports:
        - port: 3000
        targetPort: 3000
        nodePort: 30080
    selector:
        app: uda-capstone
EOF