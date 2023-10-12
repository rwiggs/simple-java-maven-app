
#!/usr/bin/env bash -x
echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo 'The following complex command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]" | sed 's/\n//g'`

echo 'The following complex command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]" | sed 's/\n//g'`

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
MYAPP="$(echo ${NAME}-${VERSION}.jar | tr -dc '\n\r'  )"

java -jar target/${MYAPP}
