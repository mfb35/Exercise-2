javac -cp CommandLineJunit/junit-4.12.jar:CommandLineJunit/hamcrest-core-1.3.jar:CommandLineJunit/mockito-core-1.10.19.jar:CommandLineJunit/objenesis-2.4.jar -d bin *.java

java -cp bin:CommandLineJunit/junit-4.12.jar:CommandLineJunit/hamcrest-core-1.3.jar:CommandLineJunit/mockito-core-1.10.19.jar:CommandLineJunit/objenesis-2.4.jar TestRunner buggy
