FROM golang:alpine AS build

WORKDIR /go/src/app
ADD /app/main.go /go/src/app/
ADD /app/main_test.go /go/src/app/
ADD /app/static/ /go/src/app/

RUN go build -o helloworld .

FROM golang:alpine

LABEL maintainer="nico@meisenzahl.org" \
org.label-schema.vcs-url="https://gitlab.com/nmeisenzahl/tekton-demo"

WORKDIR /go/src/app
COPY --from=build /go/src/app/ /go/src/app/

EXPOSE 8000

ENTRYPOINT ["/go/src/app/helloworld"]
