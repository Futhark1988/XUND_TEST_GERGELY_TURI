*** Settings ***
Resource          ../Resources/Keywords/Keywords.resource

*** Test Cases ***
Check the causes: Headache
    Open XUND    Chatbot
    Language is    English
    Click on the button    ${BTN_UNDERSTAND_SYMPTOMS}
    Accept General Terms
    The following text is displayed:    ${Q_YEAR_OF_BIRTH}
    Type in year    1989
    Click on the button    ${BTN_CONFIRM}
    Click on the button    ${BTN_EDIT_ANSWER}
    Click on the button    ${BTN_EDIT_ANYWAY}
    Type in year    1989
    Click on the button    ${BTN_CONFIRM}
    The following text is displayed:    ${Q_WHAT_GENDER}
    Click on the button    ${MALE}
    The following text is displayed:    ${I_FIRST_STEP}
    The following text is displayed:    ${Q_MAIN_SYMPTOMS}
    All entries are shown for    @{LIST_OF_HEAD_FRONT}
    All entries are shown for    @{LIST_OF_HEAD_BACK}
    All entries are shown for    @{LIST_OF_ABDOMEN}
    All entries are shown for    @{LIST_OF_HIPS}
    All entries are shown for    @{LIST_OF_UPPER_ARM}
    All entries are shown for    @{LIST_OF_LOWER_ARM}
    All entries are shown for    @{LIST_OF_LEGS}
    All entries are shown for    @{LIST_OF_LOWERBACK}
    All entries are shown for    @{LIST_OF_BACK}
    Search via input field for the body part    ${HEAD}
    Select body part    ${HEAD}
    The following text is displayed:    ${Q_SYMPTOMS_EXPERIENCED}
    Search via input field for the symptom    ${S_HEADACHE}
    Select symptom    ${S_HEADACHE}
    The following text is displayed:    ${Q_NECK_INJURY}
    Click on the button    ${BTN_YES}
    The following text is displayed:    ${Q_OVER_THE_COUNTER}
    Click on the button    ${BTN_NO}
    The following text is displayed:    ${Q_HEADACHE_BEFORE}
    Click on the button    ${BTN_NO}.
    The following text is displayed:    ${Q_HEADACHE_DURATION}
    Click on the button    ${BTN_24_HOURS}
    The following text is displayed:    ${Q_HEADACHE_SIDE}
    Click on the button    ${BTN_ON_ONE_SIDE}
    The following text is displayed:    ${BTN_ON_ONE_SIDE}
    Click on the button    ${BTN_DULL_PRESSING}
    The following text is displayed:    ${Q_HEADACHE_SEVERITY}
    Click on the button    ${BTN_MODERATE}
    The following text is displayed:    ${I_SUGGESTING_MORE_SYMPTOMS}
    The following text is displayed:    ${Q_OTHER_SYMPTOMS}
    Number of listed symptoms    6
    Click on the button    ${S_FATIGUE}
    Number of listed symptoms    9
    Click on the button    ${BTN_CONFIRM}
    The following text is displayed:    ${Q_OTHER_SYMPTOMS}
    Number of listed symptoms    6
    Click on the button    ${S_PHYSICAL_EXHAUSTION}
    Number of listed symptoms    9
    Click on the button    ${BTN_CONFIRM}
    The following text is displayed:    ${Q_ADD_SYMPTOMS}
    Click on the button    ${BTN_NO}
    The following text is displayed:    ${I_CHECK_SYMPTOMS}
    Click on the button    ${BTN_CONFIRM}
    The following text is displayed:    ${I_FINAL_QUESTIONS}
    The following text is displayed:    ${Q_LAST_14_DAYS_COVID-19}
    Click on the button    ${BTN_NO}
    The following text is displayed:    ${Q_TIRED_AFTER_SMALL_EFFORT}
    Click on the button    ${BTN_NO}
    The following text is displayed:    ${Q_HEADACHE_BEFORE}
    Click on the button    ${BTN_NO}
    The following text is displayed:    ${I_CHECK_READY}
    Click on the button    ${BTN_UNDERSTOOD}
    The following text is displayed:    ${I_POSSIBLE_CAUSES}
    Click on the button    ${BTN_DOWNLOAD_REPORT}
    Click on the button    ${BTN_CONFIRM}
    The following text is displayed:    ${Q_WHAT_TO_DO_NEXT}
    Click on the button    ${BTN_END_CHECK}
