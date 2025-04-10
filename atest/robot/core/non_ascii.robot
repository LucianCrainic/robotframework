*** Settings ***
Suite Setup       Run Tests    ${EMPTY}    misc/non_ascii.robot core/non_ascii_failure_in_suite_setup_and_teardown.robot
Resource          atest_resource.robot
Variables         unicode_vars.py

*** Test Cases ***
Non-ASCII Log Messages
    ${tc} =    Check Test Case    ${TESTNAME}
    Check Log Message    ${tc[0, 0]}    ${MESSAGE1}
    Check Log Message    ${tc[0, 1]}    ${MESSAGE2}
    Check Log Message    ${tc[0, 2]}    ${MESSAGE3}

Non-ASCII Return Value
    ${tc} =    Check Test Case    ${TESTNAME}
    Check Log Message    ${tc[2, 0]}    Français

Non-ASCII In Return Value Attributes
    ${tc} =    Check Test Case    ${TESTNAME}
    Check Log Message    ${tc[0, 0]}    ${MESSAGES}
    Check Log Message    ${tc[0, 1]}    \${obj} = ${MESSAGES}
    Check Log Message    ${tc[1, 0]}    ${MESSAGES}

Non-ASCII Failure
    ${tc} =    Check Test Case    ${TESTNAME}    FAIL    ${MESSAGES}
    Check Log Message    ${tc[0, 0]}    ${MESSAGES}    FAIL

Non-ASCII Failure In Setup
    ${tc} =    Check Test Case    ${TESTNAME}    FAIL    Setup failed:\n${MESSAGES}
    Check Log Message    ${tc.setup[0]}    ${MESSAGES}    FAIL

Non-ASCII Failure In Teardown
    ${tc} =    Check Test Case    ${TESTNAME}    FAIL    Teardown failed:\n${MESSAGES}
    Check Log Message    ${tc.teardown[0]}    ${MESSAGES}    FAIL

Non-ASCII Failure In Teardown After Normal Failure
    Check Test Case    ${TESTNAME}    FAIL    Just ASCII here\n\nAlso teardown failed:\n${MESSAGES}

Ñöñ-ÄŚÇÏÏ Tëśt äņd Këywörd Nämës, Спасибо
    ${tc} =    Check Test Case    ${TESTNAME}
    Should Be Equal      ${tc[0].name}     Ñöñ-ÄŚÇÏÏ Këywörd Nämë
    Check Log Message    ${tc[0, 0, 0]}    Hyvää päivää

Non-ASCII Failure In Suite Setup and Teardown
    Check Test Case    ${TESTNAME}
    Check Log Message    ${SUITE.suites[1].setup[0]}       ${MESSAGES}    FAIL
    Check Log Message    ${SUITE.suites[1].teardown[0]}    ${MESSAGES}    FAIL
