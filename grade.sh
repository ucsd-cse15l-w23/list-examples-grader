CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
    echo 'ListExamples.java exists'
else 
    echo 'ListExamples.java does not exist'
    exit
fi

cp ../TestListExamples.java .
cp -r ../lib .

javac -cp $CPATH *.java
echo 'Finished compiling'

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > ../output.txt
echo 'Finished running tests'

if [[ `grep -h "OK" ../output.txt` != "" ]] 
then
    echo 'All tests passed'
else
    TESTS=`grep -h "Tests run" ../output.txt`
    echo $TESTS
fi



# rm -rf student-submission
# echo 'Finished cleaning up'

