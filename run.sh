#!/bin/sh

set -o errexit

test -z "$SPARK_MASTER" && ( echo "SPARK_MASTER is not set; exiting" ; exit 1 )
test -z "$MAIN_CLASS" && ( echo "MAIN_CLASS is not set; exiting" ; exit 1 )

echo "Cloning the repository"
git clone https://github.com/tashoyan/sc.git

# Hardcoded URL and local path
# Assembly, fallback to package
echo "Building the jar"
cd sc/05-functional-programming-in-scala-capstone/observatory/
pwd
ls -la
sbt clean assembly

echo "Running the application"
jarfile="$(find target/ -type f -name *-assembly*.jar)"
spark-submit --master "$SPARK_MASTER" --class "$MAIN_CLASS" $jarfile
