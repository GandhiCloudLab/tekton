FROM anapsix/alpine-java:8
WORKDIR /
ADD target/tekton-cart-0.0.1-SNAPSHOT.jar tekton-cart.jar
RUN sh -c 'touch /tekton-cart.jar'
EXPOSE 80
ENTRYPOINT ["java","-jar","/tekton-cart.jar"]
