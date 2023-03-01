CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
CHECKEDFILE='ListExamples.java' 

rm -rf student-submission
git clone $1 student-submission

echo 'Finished cloning...'

cd student-submission

if [[ -f $CHECKEDFILE ]]
then 
    echo $CHECKEDFILE 'found!'
else 
    echo 'error:' $CHECKEDFILE 'not found.'
exit
fi

echo '/////'

javac $CHECKEDFILE

if [[ $? -ne 0 ]]
then 
    echo 'error:' $CHECKEDFILE 'did not compile'
    exit
    
else
    echo $CHECKEDFILE 'compiles!'
fi

cd .. 

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
echo 'compiling JUnit...'
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples.java

count=$(java -cp . ListExamples)

echo $? 'out of' $count 'tests passed'
