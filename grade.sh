#!/bin/bash

CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Clone the repository of the student submission to a well-known directory name (provided in starter code)
rm -rf student-submission
git clone "$1" student-submission
echo 'Finished cloning'

# Check that the student code has the correct file submitted.
if [[ ! -f student-submission/ListExamples.java ]] 
then
  echo "Error: ListExamples.java not found in student submission."
  exit 1
fi

# Get the student code and your test .java file into the same directory
mkdir -p temp
cp student-submission/ListExamples.java temp/
cp TestListExamples.java temp/
cp -r lib temp/
cd temp

# Compile your tests and the student’s code from the appropriate directory with the appropriate classpath commands.
if ! javac -cp "$CPATH" *.java; then
  echo "Error: Compilation failed."
  exit 1
fi

# # Run the tests and report the grade based on the JUnit output.
# if [[ junit_output=$(java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples 2>&1) ]] 
# then
#   echo "$junit_output"
#   grade=$(echo "$junit_output" | grep -oP '(?<=\().*(?=%\))')
#   echo "Grade: $grade"
# else
#   echo "Error: Tests failed."
#   exit 1
# fi

# run tests and report grade
echo "Running tests..."

test_results=$(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples)
num_tests=$(echo "$test_results" | awk '/Tests run:/{print $3}')
num_failures=$(echo "$test_results" | awk '/Failures:/{print $2}')

if [[ "$num_failures" -gt 0 ]]; then
  grade=0
else
  grade=100
fi

echo "Test Results: $num_tests tests run, $num_failures test failures"
echo "Grade: $grade/100"

cd ..
rm -rf temp
