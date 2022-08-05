This project reproduces a bug with the Java 11 AWS Lambda Runtime.

## Instructions

Run `./build_and_run_docker.sh`

You should see output like:

```
[INFO] Scanning for projects...
[INFO] 
[INFO] ------< com.garethdanielsmith:java-11-lambda-missing-fields-poc >-------
[INFO] Building java-11-lambda-missing-fields-poc 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ java-11-lambda-missing-fields-poc ---
[INFO] Deleting /Users/garethsmith/projects/random/java-11-lambda-missing-fields-poc/target
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ java-11-lambda-missing-fields-poc ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ java-11-lambda-missing-fields-poc ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
[INFO] Compiling 3 source files to /Users/garethsmith/projects/random/java-11-lambda-missing-fields-poc/target/classes
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ java-11-lambda-missing-fields-poc ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /Users/garethsmith/projects/random/java-11-lambda-missing-fields-poc/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ java-11-lambda-missing-fields-poc ---
[INFO] Nothing to compile - all classes are up to date
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ java-11-lambda-missing-fields-poc ---
[INFO] No tests to run.
[INFO] 
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ java-11-lambda-missing-fields-poc ---
[INFO] Building jar: /Users/garethsmith/projects/random/java-11-lambda-missing-fields-poc/target/java-11-lambda-missing-fields-poc-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.030 s
[INFO] Finished at: 2022-08-05T09:20:01+01:00
[INFO] ------------------------------------------------------------------------
Java 8:
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
2022/08/05 08:20:03 In /invocation/next
2022/08/05 08:20:03 Waiting for next event...
START RequestId: 57157120-c096-1a0a-396f-d66debc7e1ee Version: $LATEST
2022/08/05 08:20:04 Setting Reply in /response
2022/08/05 08:20:04 In /invocation/next
2022/08/05 08:20:04 Reply is not nil
2022/08/05 08:20:04 EndInvoke()
END RequestId: 57157120-c096-1a0a-396f-d66debc7e1ee
REPORT RequestId: 57157120-c096-1a0a-396f-d66debc7e1ee  Init Duration: 2190.16 ms       Duration: 122.83 ms     Billed Duration: 123 ms Memory Size: 1536 MB    Max Memory Used: 189 MB 
2022/08/05 08:20:04 Waiting for next event...

{"parentField":"_parentField","testChild":"_testChild"}
Java 11:
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
2022/08/05 08:20:06 In /invocation/next
2022/08/05 08:20:06 Waiting for next event...
START RequestId: 171458f9-c71d-1a42-0f19-7cb0f46f288a Version: $LATEST
2022/08/05 08:20:06 Setting Reply in /response
2022/08/05 08:20:06 In /invocation/next
2022/08/05 08:20:06 Reply is not nil
2022/08/05 08:20:06 EndInvoke()
END RequestId: 171458f9-c71d-1a42-0f19-7cb0f46f288a
REPORT RequestId: 171458f9-c71d-1a42-0f19-7cb0f46f288a  Init Duration: 1422.87 ms       Duration: 55.96 ms      Billed Duration: 56 ms  Memory Size: 1536 MB    Max Memory Used: 182 MB 
2022/08/05 08:20:06 Waiting for next event...

{"parentField":"_parentField"}
```

The lambda is run twice, first on the Java 8 runtime and then on Java 11. Each time the output is printed.

Observe that Java 8 produces this output JSON:

```
{"parentField":"_parentField","testChild":"_testChild"}
```

but Java 11 produces JSON that is missing the field from the child class:
```
{"parentField":"_parentField"}
```
__This is: https://github.com/aws/aws-lambda-java-libs/issues/358__