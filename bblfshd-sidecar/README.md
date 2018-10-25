# Babelfish "sidecar" server

This chart gives a template to deploy a [Babelfish server](https://doc.bblf.sh/) container into another deployment

## Using the Chart

Once this chart has been added to `requirements.yml` you need to import the chart's components in the pos where you want bblfshd.
This will allow you to connect to bblfshd on localhost on port `9432`

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: dummy-app
  labels:
    app: dummy-app
spec:
  replicas: 1
  selector:
  template:
    spec:
      volumes:
{{ include "bblfshd-sidecar.volumes" . | indent 8 }}
      containers:
{{ include "bblfshd-sidecar.containers" . | indent 8 }}
        - name: app
          image: src-d/dummy:1.0.0
          env:
            - name: BBLFSH_URL
              value: localhost:9432
```
