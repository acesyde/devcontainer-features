#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

check "user is root" grep root <(whoami)

check "java" java --version
check "gradle version" grep "Gradle 6.8.3" <(gradle --version)

cd /tmp && gradle init --type basic --dsl groovy --project-name test
check "GRADLE_USER_HOME exists" grep ".gradle" <(ls -la /root)

check "maven version" grep "Apache Maven 3.6.3" <(mvn --version)
cd /tmp && mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
check "m2 exists" grep ".m2" <(ls -la /root)

# Report result
reportResults
