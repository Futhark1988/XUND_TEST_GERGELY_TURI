# **2.1 Test strategy**

> The medical database can change from time to time (which means new questions might appear during
the check). What problems do you see with this property of the system? What test strategy would you
use for maintainable test automation? Write a few sentences about your thoughts.

The main problem is that the automated test cases would have to be updated everytime changes occur in the database.
While testing the Webapp and Chatbot I noticed that even within a few days the order of the questions and even the ID of some elements changed.
In case of a very low number of test cases e.g. 4-5 this is still manageable, but it becomes tedious and extremely time-consuming with e.g. 400 test cases.
Therefore it is advised to use reusable elements, like variables and parametrized functions.

Just like in programming, when automating a test, the repetition of code should be avoided, and it should be as concise as possible.
When objects and values need an update, the changes only happen in one place in the test script instead of several times in the same file or suite.
For example the text on the seperate pages can be stored in variables instead of hard-coding them in the test cases. In case the the text changes you only need to change it in one place. 

**Possible solution:**

A possible solution would be to export the causes of the symtopms, along with the questions asked about them in  XML or JSON files
e.g.

	[
	"Headache":  {
			"symptoms": [
					"Question_1": {
							"text": "Have you experienced similar headaches before?"
							"options": ["Yes","No"]
					}
					"Question_2": {
							"text": "Have you been suffering from such complaints regularly for a longer period of time?"
							"options": ["Yes","No"]
					}	]
	}
	]


If the user selects headache, then the list of all the questions related to "headache" should be traversed in the list and in case the question is in the list it should expect the possible options. 

So if Question 1 and Question 2 would switch places it wouldn't matter, as they would both be in the list of questions.

Lets assume that we have a phrase in Robot Framework like this:
	
	The patient has a 'Headache' that is due to 'COVID-19'

The 'Headache' would be set as the starting point/node and 'COVID-19' would be set as the end point/node.

The script would then select the questions and answers (so the route) that leads from 'Headache' to 'COVID-19', and even if the order of the questions change, or there are more questions added in between, the test case would (IN THEORY) not break. 

After that you could check each and every option, and even every following question that is connected to the option.
The script traversing the list/JSON/XML would start the next test execution once the last child element has been reached.
The problem with this is that it is very time consuming and it might not be advisable to test it using the UI, as that tends to be slow, and should be sent via the API.

But the only way to keep the test automation maintainable and the system under test (relatively) bug-free is by testing often and continously, which means at least once a day tests should be run in a CI/CD tool like Jenkins.


# **2.2 Test plan**

> Create a draft test plan concept for the symptom checker. No need to dive deep in the details, the
structure of the document, and explanation about the content are enough.

### **The purpose of the document:**

This document is intended to give an overview for all stakeholder on the testing of the Webapp and Chatbot at XUND.

### **Participants:**

Testing performed by: Gergely Turi

### **Schedule:**

Start: N/A

End: N/A

### **Testing objective:**

As an exhaustive testing of the applications Webapp and Chatbot is not possible due to time and budget restrictions the following feature are to be tested are defined "in scope" and "out of scope respectively"

**In Scope:**
	
- The Symptoms checker function :
	
	
	- The user is able to open the Webapp and Chatbot applications.
		
	- The user is able to select and fill out personal information such as age and gender.
		
	- The user is able to select where they experience the symptom.
		
	- The user is able to select the different symptoms.
		
	- The user gets the result of the check.
		
	- The user can download the results of the check.
	
- UI testing
	
	- All enabled buttons are clickable and trigger an event.
		
	- Clicking on the different UI elements do not trigger errors

**Out of Scope:**
	
-  Software Interfaces
	
-  Database logic
	
-  APIs
	
-  Website Security
	
-  Performance

### **Test completeness:**
	
The testing phase is considered successful when the test cases are executed and the main functionality of the application work according to the specifications.
	
Run rate: 100 % of the test cases must be executed by the end of the test phase.
	
Pass rate: 80 % of the test cases must pass in order to verify the defined functionalities of the systems in test.

### **Test suspension criteria:**
	
Testing should be suspended if the team members report that there are **20%** of test cases **failed**.

### **Test Deliverables**

Test deliverables are provided as below

**Before testing phase**
	
-   Test plans document.
	
-   Test cases documents
	
-   Test design specifications.

**During the testing**
	
-   Test Data
	
-   Error logs and execution logs.

**After the testing cycles is over**
	
-   Test Results/reports
	
-   Defect Report
	
-   Installation/ Test procedures guidelines
	
-   Release notes


# **2.3 Test case**

> In the draft test plan define a test case that tests the main symptom selector feature.

```
	Pseudocode:
		Given the question "Where do you experience your main symptom?" is displayed
		Then all the main part of the body are listed on the left-hand side
		And the 'front' side of the body is displayed on the right side
		When you click on the 'Head' of the body on the right-hand side
		Then the body parts that are part of the 'front' side of the 'Head' are listed on the left-hand side
		And the body parts that are not part of the 'front' side of the 'Head' are listed on the left-hand side
		When you click on the 'Head' of the body on the right-hand side
		Then all the main part of the body are listed on the left-hand side
		When you click on 'Rotate' on the right-hand side
		Then the 'back' side of the body is displayed on the right-hand side
		Then the body parts that are part of the 'back' side of the 'Head' are listed on the left-hand side
		And the body parts that are not part of the 'back' side of the 'Head' are listed on the left-hand side
		When you click on the 'Head' of the body on the right-hand side
		Then all the main part of the body are listed on the left-hand side
		When you click on 'Rotate' on the right-hand side
		Then the 'front' side of the body is displayed on the right side
		And all the main part of the body are listed on the left-hand side
		When you type in 'Head' in the search field on the left-hand side
		And click on Search on the left-hand side
		Then only the head is in the list on the left-hand side
		When you select 'Head' from the list on the left-hand side
		Then the question "Which symptom do you experience?" is displayed
		When you type in 'Headache' in the search field
		Then all 'Headache' related symptoms are listed
		When you select 'Headache'
		Then questions in connection with 'Headache' are displayed
```
# **2.4 Test automation script**

> Create a test automation script that runs a symptom check until the report. This test automation script
> should Include the test case from 2.3 for the first part of the check, and should continue until the check
> report.
> The test automation script should generate a report which will be part of a release documentation.

**Tools and environment used for testing:**

Environment: Windows 11

Tools and packages:

- Python 3.10.7.
	
- robotframework v6.0
	
- robotframework-assertion-engine v0.6.0
	
- robotframework-browser v14.2.1
	
- RIDE v2.0b3.dev1

A report is automatically generated by Robot Framework after every run.


# **2.5 Advanced questions**

> How would you automate tests for the exportable PDF report?
	
Since I have never had to test anything like this I might not give the best answer to this question, but a possible tool would be an RPA tool e.g. Robot Framework, Robocorp or their more expensive alternatives UiPath.

First you would have to define what the PDF should contain. This can be saved in a simple text file. The text on the printed PDF should be scraped and  compared to that in the text file.

If the layout should be tested than I would make use image based searches done on the printed PDF. For this you would first need and anchor with an absolute position as well as an anchor with a relative position. An anchor could be anything that doesn't change (often) on a document e.g. "Presented symptoms" and then check  how many ticks with text next to them are listed below it.

> How would you Test the system on the different available languages?
	
Please check my test cases.

The translations of the UI elements should be in separate files. Of course they can all be in one file as well, but separate files/languages can be assigned to different people and the risk of locking the file and /or inadvertantly deleting or editing the work of others is reduced.

You can declare a variable for the different elements but for each language the same variable named should be used.

E.g. variable ${HEAD} would have the value 'Head' in English and in German the same variable would have the value 'Kopf'
