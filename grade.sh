CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
cd student-submission
echo 'Finished cloning'
if [[ -f ListExamples.java ]]
then
    echo "ListExamples found"
else 
    echo "need file ListExamples.java"
    exit 1
fi
cp ./ListExamples.java ../

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
if [[ $? -ne 0 ]]
then
    echo "Compilation fails"
    exit 1
else
    echo "Compile success"
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples
