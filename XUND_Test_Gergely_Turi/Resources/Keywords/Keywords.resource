*** Settings ***
Library           String
Library           Browser
Library           Collections

***Variables***
&{LANGUAGES}      English=English    German=Deutsch    Formal German=Deutsch formal    Hungarian=Magyar    Russian=Pусский
${WEBAPP}		'https://webapp.demo.xund.solutions'
${CHATBOT}		'https://chatbot.demo.xund.solutions'
&{XUND_URLs}		Webapp=${WEBAPP}	Chatbot=${CHATBOT}
${CURRENT_URL}		${EMPTY}

*** Keywords ***
Accept General Terms
	IF		${CURRENT_URL} == ${CHATBOT}
		Get Element States    id=xund-iframe >>> xpath=//article[contains(text(),"${I_GENERAL_TERMS_TEXT}")]    then    bool(visible & enabled)
		Click		css=#terms_confirm
	END
	
All entries are shown for
    [Arguments]    @{LIST_OF_ENTRIES}
	IF		${CURRENT_URL} == ${WEBAPP}
		FOR    ${ENTRY}    IN    @{LIST_OF_ENTRIES}
        Get Element States    id=xund-iframe >>> xpath=//span[@class="ant-input-wrapper ant-input-group"]/span/button/span[contains(text(), "${ENTRY}")]    then    bool(visible & enabled)
		END
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		FOR    ${ENTRY}    IN    @{LIST_OF_ENTRIES}
        Get Element States    css=#body_part_answer_${ENTRY} > div    then    bool(visible & enabled)
		END
	END 
	
Click on body part
	[Arguments]    ${SELECTED_BODY_PART}
	IF		${CURRENT_URL} == ${WEBAPP}
		Click    id=xund-iframe >>> css=#${SELECTED_BODY_PART}
	END

Click on the button
    [Arguments]    ${BUTTON_CAPTION}
	IF		${CURRENT_URL} == ${WEBAPP}
		Click    id=xund-iframe >>> xpath=//span[contains(text(),"${BUTTON_CAPTION}")]|//h4[contains(text(),"${BUTTON_CAPTION}")]
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Click    xpath=(//button/div[contains(text(),"${BUTTON_CAPTION}")]|//button[contains(text(),"${BUTTON_CAPTION}")])[last()]
	END
    

General Terms are displayed
	IF		${CURRENT_URL} == ${WEBAPP}
		The following text is displayed:    ${I_GENERAL_TERMS}
		Get Element States    id=xund-iframe >>> xpath=//article[contains(text(),"${I_GENERAL_TERMS_TEXT}")]    then    bool(visible & enabled)
	END
    
	
Language is
    [Arguments]    ${SELECTED_LANGUAGE}
	IF		${CURRENT_URL}==${WEBAPP}
		Click    id=xund-iframe >>> id=menu-btn
		Click    id=xund-iframe >>> id=change-language-menu-item
		Click    id=xund-iframe >>> xpath=//div[@role="dialog"]//*[contains(text(), "${SELECTED_LANGUAGE}")]
		Click    id=xund-iframe >>> xpath=//div[@role="dialog"]//div[@class="ant-modal-footer"]//button[2]
		Import Resource    ${EXECDIR}/../Resources/Variables/Anatomy_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Buttons_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Information_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Questions_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Symptoms_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
	END
	IF		${CURRENT_URL}==${CHATBOT}
		Click    id=menu-btn
		Click    id=change-language-menu-item
		Click    xpath=//*[text()="${LANGUAGES}[${SELECTED_LANGUAGE}]"]
		Click    xpath=//button[text()="Restart"]
		Import Resource    ${EXECDIR}/../Resources/Variables/Anatomy_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Buttons_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Information_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Questions_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
		Import Resource    ${EXECDIR}/../Resources/Variables/Symptoms_${LANGUAGES}[${SELECTED_LANGUAGE}].resource
	END

Move age slider to
    [Arguments]    ${AGE}
	IF		${CURRENT_URL} == ${WEBAPP}
		Click    id=xund-iframe >>> css=div.ant-slider-handle
		${EARLIEST_DATE_STR}=    Get Text    id=xund-iframe >>> xpath=//*[@id="background_image"]/div/div[2]/div/div[2]/div[1]/div[2]/div/div/div/div[5]/span[1]
		${LATEST_DATE_STR}=    Get Text    id=xund-iframe >>> xpath=//*[@id="background_image"]/div/div[2]/div/div[2]/div[1]/div[2]/div/div/div/div[5]/span[2]
		${CURRENT_DATE_STR}=    Get Text    id=xund-iframe >>> xpath=//*[@id="background_image"]/div/div[2]/div/div[2]/div[1]/div[2]/div/div/div/div[5]/span[3]
		${EARLIEST_DATE_INT}=    Convert To Integer    ${EARLIEST_DATE_STR}
		${LATEST_DATE_INT}=    Convert To Integer    ${LATEST_DATE_STR}
		${CURRENT_DATE_INT}=    Convert To Integer    ${CURRENT_DATE_STR}
		${DATE_RANGE}=    Evaluate    ${LATEST_DATE_INT}-${EARLIEST_DATE_INT}
		IF    ${AGE}>${EARLIEST_DATE_INT} and ${AGE}<${LATEST_DATE_INT}
			WHILE    ${AGE}!=${CURRENT_DATE_INT}
				IF    ${CURRENT_DATE_INT}<${AGE}
					Keyboard Key    press    ArrowRight
					${CURRENT_DATE_STR}=    Get Text    id=xund-iframe >>> xpath=//*[@id="background_image"]/div/div[2]/div/div[2]/div[1]/div[2]/div/div/div/div[5]/span[3]
					${CURRENT_DATE_INT}=    Convert To Integer    ${CURRENT_DATE_STR}
				END
				IF    ${CURRENT_DATE_INT}>${AGE}
					Keyboard Key    press    ArrowLeft
					${CURRENT_DATE_STR}=    Get Text    id=xund-iframe >>> xpath=//*[@id="background_image"]/div/div[2]/div/div[2]/div[1]/div[2]/div/div/div/div[5]/span[3]
					${CURRENT_DATE_INT}=    Convert To Integer    ${CURRENT_DATE_STR}
				END
			END
		ELSE
			Log    ${AGE} is out of bound!    WARN
		END
	END
	
Number of listed symptoms
    [Arguments]    ${NUMBER}
	IF		${CURRENT_URL} == ${WEBAPP}
		Get Element States    id=xund-iframe >>> xpath=span[@class="ant-input-wrapper ant-input-group"]//*[count(*)=${NUMBER}]    then    bool(visible & enabled)
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Get Element States    xpath=//*[@id="root"]/div/div/div/div[3]//*[count(*)=${NUMBER}]    then    bool(visible & enabled) 
	END

Open XUND 
	[Arguments]		${APP_NAME}
	IF		${XUND_URLs}[${APP_NAME}]
		${SELECTED_APP}=	Get From Dictionary	${XUND_URLs}	${APP_NAME}
		Set Global Variable		${CURRENT_URL}		${SELECTED_APP}
		New Browser    chromium    headless=false
		New Context    viewport={'width': 720, 'height': 640}
		IF		${CURRENT_URL}==${WEBAPP}
			New Page    https://webapp.demo.xund.solutions
			Wait For Elements State    id=xund-iframe    attached
		END
		IF		${CURRENT_URL}==${CHATBOT}
			
			New Page    https://chatbot.demo.xund.solutions
			Wait For Elements State    xpath=//*[@id="root"]/div/div/div/div[3]    attached
		END
	ELSE
		LOG		${APP_NAME} is not supported.
	END
	Set Browser Timeout		20s
	
Severity level
    [Arguments]    ${PAIN}
	IF		${CURRENT_URL} == ${WEBAPP}
		Click    id=xund-iframe >>> css=div.ant-slider-handle
		${MIN}    Set Variable    ${1}
		${MAX}    Set Variable    ${10}
		${NOW}    Set Variable    ${5.5}
		IF    ${PAIN}>${MIN} and ${PAIN}<${MAX}
			WHILE    ${NOW}!=${PAIN}
				IF    ${NOW}<${PAIN}
					Keyboard Key    press    ArrowRight
					${NOW}    Set Variable    ${NOW+0.5}
				END
				IF    ${NOW}>${PAIN}
					Keyboard Key    press    ArrowLeft
					${NOW}    Set Variable    ${NOW-0.5}
				END
			END
		ELSE
			Log    ${PAIN} is out of bound!    WARN
		END
	END
Search via input field for the body part
    [Arguments]    ${SELECTED}
	IF		${CURRENT_URL} == ${WEBAPP}
		Type Text    id=xund-iframe >>> xpath=//input[@placeholder="Search"]    ${SELECTED}
		Click    id=xund-iframe >>> xpath=//input[@placeholder="Search"]/..//button
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Type Text    xpath=//*[@id="body_part_search_bar"]    ${SELECTED}
	END
    
    

Search via input field for the symptom
    [Arguments]    ${SELECTED}
	IF		${CURRENT_URL} == ${WEBAPP}
		Type Text    id=xund-iframe >>> xpath=//input[@placeholder="Search"]    ${SELECTED}
		Click    id=xund-iframe >>> xpath=//input[@placeholder="Search"]/..//button
		Get Element States    id=xund-iframe >>> xpath=span[@class="ant-input-wrapper ant-input-group"]//*[count(*)=${SELECTED}]    then    bool(visible & enabled)
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Type Text    xpath=//*[@id="symptom_select_search_bar"]    ${SELECTED}
	END
    
		
Select body part
	[Arguments]    ${SELECTED_BODY_PART}
	IF		${CURRENT_URL} == ${WEBAPP}
		Click    id=xund-iframe >>> xpath=//span[contains(text(),"${SELECTED_BODY_PART}")]
		${NUMBER_OF_ELEMENTS_IN_LIST}=    Get Length    ${LIST_OF_${SELECTED_BODY_PART}_FRONT}
		Get Element States    id=xund-iframe >>> xpath=span[@class="ant-input-wrapper ant-input-group"]//*[count(*)=${NUMBER_OF_ELEMENTS_IN_LIST}]    then    bool(visible & enabled)
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Click    css=#body_part_answer_${SELECTED_BODY_PART} > div.searchTitle
	END
	
	
Select symptom
	[Arguments]    ${SELECTED_SYMPTOM}
	IF		${CURRENT_URL} == ${WEBAPP}
		Click    id=xund-iframe >>> xpath=//p[contains(text(),"${SELECTED_SYMPTOM}")]
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Click    css=#${SELECTED_SYMPTOM}_select_button > div.searchTitle
	END
	
	
Start page is displayed
	IF		${CURRENT_URL} == ${WEBAPP}
		The following text is displayed:    ${GREETING}
		The following text is displayed:    ${Q_SUFFERING_FROM_SPECIFIC_ILLNESS}
	END
	
The following text is displayed:
    [Arguments]    ${TEXT}
	IF		${CURRENT_URL} == ${WEBAPP}
		Get Element States    id=xund-iframe >>> xpath=//h1[contains(text(),"${TEXT}")]    then    bool(visible & enabled)
	END
	IF		${CURRENT_URL} == ${CHATBOT}
		Get Element States    xpath=//div[contains(text(),"${TEXT}")]    then    bool(visible & enabled)
	END

Type in year
    [Arguments]    ${AGE}
	IF		${CURRENT_URL} == ${CHATBOT}
		Type Text	xpath=//input[@id="age_input"]	${AGE}
	END										 
