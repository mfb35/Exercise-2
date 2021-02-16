# CS 1632 - Software Quality Assurance
Spring Semester 2021 - Exercise 2

* DUE: Feb 17 (Wednesday), 2021 11:59 PM

## Before You Begin

Please download Eclipse IDE:
https://www.eclipse.org/downloads/

Have it downloading and installing while you read the rest of the exercise.

## Description

In this exercise, we will simulate the main Rent-A-Cat rental system software.  This is obviously a "toy" implementation of the vast and powerful Rent-A-Cat apparatus.

I have created some skeleton code for you to fill in for this exercise.  It is up to you to fill in the `returnCat()`, `rentCat()`, `listCats()` and `catExists()` methods, and write unit tests for them.  Unit tests must use doubles for the Cat object with appropriate stubbing.  I have intentionally inserted a defect on every Cat method such that an exception is fired if you try to use a real Cat object in any way during your unit testing!  Those defects are turned off when Cat is used within the main RentACat program.

Rent-A-Cat rents cats to customers for various needs (mousing, companionship, homework help, etc.).  From the main menu, users may:

1. See list of cats for rent
2. Rent a cat to a customer
3. Return a cat
4. Quit

A cat which is out for rental cannot be rented and will not be listed until it has been returned.  We will not charge money for this exercise.

## Sample Output

```
Option [1,2,3,4] > 1
Cats for Rent
ID 1. Jennyanydots
ID 2. Old Deuteronomy
ID 3. Mistoffelees
Option [1,2,3,4] > 2
Rent which cat? > 1
Jennyanydots has been rented.
Option [1,2,3,4] > 1
Cats for Rent
ID 2. Old Deuteronomy
ID 3. Mistoffelees
Option [1,2,3,4] > 2
Rent which cat? > 1
Sorry, Jennanydots is not here!
Rent which cat? > 7
Invalid cat ID.
Rent which cat? > 3
Mistoffelees has been rented.
Option [1,2,3,4] > 1
Cats for Rent
ID 2. Old Deuteronomy
Option [1,2,3,4] > 3
Return which cat? > 7
Invalid cat ID.  
Return which cat? Jennyanydots
Invalid cat ID.
Return which cat? 1
Welcome back, Jennyanydots!
Option [1,2,3,4] > 1
Cats for Rent
ID 1. Jennyanydots
ID 2. Old Deuteronomy
Option [1,2,3,4] > 4
Closing up shop for the day!
```

You will modify two classes: **RentACatImpl.java** and **RentACatTest.java**.  The RentACatImpl class is an (incomplete) implementation of the Rent-A-Cat system.  The RentACatTest class is a JUnit unit test class that tests RentACatImpl.  All locations where you should add code is marked with // TODO comments.

We are going to use the TestRunner class to invoke JUnit on the RentACatTest class.  Note how the RentACatTest.class is added to the list of classesToTest.

You should use test doubles/mocks for any references to classes other than the one under test that the tested class is dependent upon (i.e. you need to mock any Cat objects).  You do not need to mock the ArrayList class used within RentACatImpl even though RentACatImpl is dependent upon it.  ArrayList is a Java standard library class so we will assume that it is fully tested and defect-free at this point. :)

## Running Unit Tests

1. First let's do a sanity check to see if JUnit works well with the Java version installed on your machine.  For Windows try doing:
    ```
    run.bat
    ```
    For Mac or Linux, try doing:
    ```
    bash run.sh
    ```
    For those of you who prefer Makefiles, you can also do:
    ```
    make
    ```
    If successful, you will get a message "ALL TESTS PASSSED".  But hold your horses, we aren't done yet!  The tests passed because they are currently empty.
    
2. Now you are ready to fill in the test cases in RentACatTest.  If you want to do a sanity test, try a very simple assertion that always succeeds in testGetCatNullNumCats0:
    ```
    assertTrue(true);
    ```
    Now you see the message "ALL TESTS PASSED" again.  Yes!  Now let's try an assertion that fails.  Change the above to:
    ```
    assertFalse(true);
    ```
    Now you should see a test failure like the below:
    ```
    testGetCatNullNumCats0(RentACatTest): null

    !!! - At least one failure, see above.
    ```
    What does that null mean?  It just means you didn't supply a failure message.  Try the following:
    ```
    assertFalse("True is not false", true);
    ```
    Then you should get:
    ```
    testGetCatNullNumCats0(RentACatTest): True is not false

    !!! - At least one failure, see above.
    ```
    
3. Now you are ready to start writing the RentACatTest class for real.  Start
   by adding very simple tests to gain confidence.  Next, try adding more
complex cases that require Cat objects.  For that, you will have to modify
setUp() to create some Cat test doubles with proper stubs.  We learned how to
do that in class.  If you are still unsure, look at the
[LinkedListUnitTest.java](https://github.com/wonsunahn/CS1632_Spring2021/blob/main/sample_code/junit_example/LinkedListUnitTest.java)
sample code or the NoogieTest and CoogieTest under the Example/ directory.

## Tips

1. We will try to apply the Test Driven Development (TDD) model here.  Try writing the test case(s) FIRST before writing the code for a feature.  This way, you will always have 100% test coverage for the code you have written and are writing.  Hence, if you break any part of it in the course of adding a feature or refactoring your code, you will know immediately.  Otherwise, if you test at the very end, you may have to do some major changes.
1. Remember to _not_ mock the class under test (i.e. RentACat), only external classes that it depends upon (i.e. Cat).  In fact, if you don't mock Cat and use the actual Cat objects, your tests will most likely fail.  I have injected artificial defects in the form of exceptions into the Cat class to emulate a buggy Cat class.  Your tests should work regardless of what's inside Cat.
1. The easiest thing to do is assert against a return value, but you can also assert against attributes of an object.  For example:
    ```
    @Test
    public void testCatName() {
       assertEquals("Expected name", cat.getName());
    }
    ```
    You can also use the Mockito verify method to perform behavior verification.
1. Make use of the @Before and @After methods in your JUnit testing.  @Before and @After methods are invoked before and after each @Test method.  They are used to set up and tear down test fixtures.  Test fixtures in JUnit are objects that need to be created and initialized before performing each test case.  You can think of them as "actors" in your test script.  Having the @Before and @After allows us to avoid duplicating test fixture code in each test case.
1. In RentACatTest.java, pay close attention to the Javadoc comments on top of each @Test method which describe the preconditions, execution steps, and postconditions.  Remember, part of the preconditions may be already fulfilled with the test fixture initialized in the @Before method.
1. Each @Test method represents a test case.  A JUnit class with one or more @Test methods represents a test plan. A JUnit class is usually named after whichever class it is testing, with the string `Test` appended to the tested class name.  For example, Foo.java would be tested by FooTest.java.  But this is not necessarily the case.  A JUnit class may test multiple classes with related functionality; in that case, it is typically named after the functionality it is testing.
  
## Expected Outcome

Once you start filling in tests in RentACatTest, you will start to see some of those tests fail for those methods you haven't completed yet for RentACatImpl.  As you start filling in the methods in RentACatImpl, those failures will go away one by one until you again see the output:
```
ALL TESTS PASSED
```
You have come full circle!  But wait, does this mean RentACat is bug-free?  How do you know if your unit tests themselves had defects and that's why they passed, even when RentACat is buggy?We have to actually verify the unit tests themselves to make sure that they are not defective!  One way to verify unit tests is to test them on buggy programs to see if they detect the bugs as they are intended to.  I have created a buggy version of Rent-A-Cat just for this purpose named RentACatBuggy.java.  In order to apply your unit tests to RentACatBuggy, execute the following.  For Windows:
```
runBuggy.bat
```
For Mac or Linux, try doing:
```
bash runBuggy.sh
```

If you run the above, you should get output that looks like [runBuggy.output.txt](runBuggy.output.txt).  Note that I've commented out the following line at TestRunner.java:30 to make the output less verbose:
```
System.out.println(f.getTrace());
```
The above will print a full Java stack trace for every failure.  It is useful when a test fails due to a crash in your program and you want to locate exactly in which source code line the Java exception was thrown.  The defects in RentACatBuggy does not involve crashes due to exceptions so I've temporarily commented it out for brevity.

You can see that all tests fail except the ones for getCat(int id).  That is because I've inserted bugs into RentACatBuggy except for that method.  If your unit test passes any other method, it must be defective.  Time to fix your test.

## Submission

Each pairwise group will submit the exercise *once* to GradeScope, by *one member* of the group.  The submitting member will press the "View or edit group" link at the top-right corner of the assignment page after submission to add his/her partner.  That way, the feedback will be accessible to both of you.  I recommend that you divide the list of methods to implement / test into two halves and working on one half each.

You will do two submissions for this exercise.

1. You will create a github repository just for exercise 2.  Add your partner as a collaborator so both of you have access.  Make sure you keep the repository *PRIVATE* so that nobody else can access your repository.  This applies to all future submissions for this course.  Once you are done modifying code, don't forget to commit and push your changes to the github repository.  When you are done, submit your github repository to GradeScope at the "Exercise 2 GitHub" link.  Once you submit, GradeScope will run the autograder to grade you and give feedback.  If you get deductions, fix your code based on the feedback and resubmit.  Repeat until you don't get deductions.

1. Create a screenshot of code coverage stats given by your IDE of choice and name it code_coverage.png. Example:

    <img alt="Code Coverage" src=code_coverage.png width=700>

    I used Eclipse to generate the screenshot.  Here is the user guide: https://www.eclemma.org/userdoc/launching.html.  It is just a click of a button and requires no extra installation.  You don't have to have 100% coverage for this exercise but you will have coverage requirements for your deliverable.  I have already created an Eclipse project for you in the exercise directory so you can just open that to run TestRunner using File > Open Projects from File System from the menu.  If you can't open the project for some reason, you need to create a new project using File > New > Java Project.  For those of you who are new to eclipse, you need to include the four JAR files under CommandLineJUnit/ as external JARs for it to compile.  You need to go to project properties > Java Build Path > Libraries and Add JARs or Add External JARs.  Also, don't create module-info.java when prompted.
    
    When you run the code coverage tool, make sure you run TestRunner, not RentACatImpl.  You can do that by clicking on and highlighting TestRunner.java before clicking on the code coverage button.  Alternatively, you can right click on TestRunner.java and click on the "Coverage as" item in the menu that pops up.  This is important.  If you run RentACat.java, you will be getting the code coverage while playing the game.

    After you have created the screenshot, save the picture to a PDF file and submit to GradeScope at the "Exercise 2 Coverage" link.  Make sure the picture fits in one page for easy viewing and grading.

IMPORTANT: Please keep the github private!

## GradeScope Feedback

The GradeScope autograder works in 3 phases:
1. RentACatTestSolution.(some method) on RentACatImpl: RentACatTestSolution is the solution implementation of RentACatTest.  The purpose of this phase is to verify that RentACatImpl (your RentACat implementation) does not have any defects.
1. RentACatTest.(some method) on RentACatSolution: RentACatTest is your submitted JUnit test for RentACat.  The purpose of this phase is to test RentACatTest itself for defects.  RentACatSolution is the solution implementation of RentACat and contains no defects (that I know of).  Hence, all tests in RentACatTest should pass.
1. RentACatTest.(some method) on RentACatBuggy: RentACatTest is your submitted JUnit test for RentACat and you are testing against the buggy RentACatBuggy implementation.  The purpose of this phase is to further test RentACatTest for defects.  It does this by testing whether RentACatTest finds all the bugs that RentACatTestSolution is able to find within RentACatBuggy.
If you see test failures, read the feedback given by the autograder, fix your code, and retry.

Beside the feedback given by the autograder, the TA or myself will leave more detailed feedback on the "Feedback on source code" question.  We will also check your code coverage screenshot submission and give feedback.

## Resources

These links are the same ones posted at the end of the slides:

* JUnit User manual:  
https://junit.org/junit4/

* JUnit Reference Javadoc:  
http://junit.sourceforge.net/javadoc/  
For looking up methods only, not a user guide.

* Mockito User Manual:  
https://javadoc.io/static/org.mockito/mockito-core/3.2.4/org/mockito/Mockito.html  
Most useful is the sections about verification and stubbing.

* Eclipse IDE
If you want more information, here is a page put up by a U Chicago professor:  
http://people.cs.uchicago.edu/~kaharris/10200/tutorials/eclipse/index.html  
It uses a much earlier version of Eclipse, but other than the outdated UI, the operations are the same.  I looked at several resources and this one was the most concise and to the point.  A more comprehensive manual is at eclipse.org:  
https://help.eclipse.org/2019-12/index.jsp  
Look at the "Java development user guide" chapter on the left.
