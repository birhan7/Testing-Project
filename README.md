AutomationExercise.com Test Suite

This project contains a comprehensive suite of automated tests for [AutomationExercise.com](https://automationexercise.com), designed to validate key functionalities of the website. The tests are implemented using the **Robot Framework**, with support from Selenium, Python, and other testing tools.

Project Goals

-  Validate all functional test scenarios listed on AutomationExercise.
-  Provide a maintainable and scalable test framework.
-  Support manual CAPTCHA handling during execution.
-  Generate detailed test reports and logs.

 Tech Stack

- **Language**: Python 3
- **Framework**: [Robot Framework](https://robotframework.org/)
- **Libraries**:
  - SeleniumLibrary
  - RequestsLibrary (for API tests if applicable)
  - BuiltIn
- **Tools**: ChromeDriver, pip, virtualenv

---
Project Structure
venv/
├── APItesting/
│   ├── resources/
│   ├── tests/
│   ├── variables/
│   └── output/
└── functional_testing/
|   ├── resources/
|   ├── tests/
|   ├── variables/
|   ├── output/
└── LoadTest/
      ├── locustfile.py
- All the test folders contains all the test cases.



