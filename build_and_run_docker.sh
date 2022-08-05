mvn clean verify

echo "Java 8:"
docker run \
  -e DOCKER_LAMBDA_DEBUG=true \
  -v "$PWD/target/classes:/var/task:ro,delegated" \
  lambci/lambda:java8 \
  "com.garethdanielsmith.TestLambda" "null"

echo "Java 11:"
docker run \
  -e DOCKER_LAMBDA_DEBUG=true \
  -v "$PWD/target/classes:/var/task:ro,delegated" \
  lambci/lambda:java11 \
  "com.garethdanielsmith.TestLambda" "null"