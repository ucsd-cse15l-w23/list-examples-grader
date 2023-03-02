CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission

cd student-submission
if [ -f ListExamples.java ]
then
    echo "ListExamples.java found"
else
    echo "Files Not found"
    exit 1
fi
cd ..
cp -r lib student-submission
cd student-submission
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> javac-errors.txt

if [[ $? -ne 0 ]]
then
    echo javac-errors.txt
fi


java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples

echo 'Finished cloning'
