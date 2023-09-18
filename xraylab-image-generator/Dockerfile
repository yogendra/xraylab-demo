# IMG=xraylab-image-generator  TAG=v2.0 docker buildx build --platform linux/amd64,linux/arm64  -t yogendra/$IMG:$TAG -t ghcr.io/yogendra/$IMG:$TAG -t quay.io/yogendra/$IMG:$TAG --push -f Dockerfile .

FROM registry.access.redhat.com/ubi8/python-39:1-24

WORKDIR /usr/src/app

COPY . ./

RUN pip install -r requirements.txt

CMD ["python", "-u", "image-generator.py"]
