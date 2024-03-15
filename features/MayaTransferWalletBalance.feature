# Scenario Writing: 
# Create test scenarios where you as a Maya user transfer your wallet balance. Consider positive and negative scenarios.

Feature: Maya Transfer Wallet Balance

  Scenario: Transfers wallet funds with sufficient balance to another user successfully
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    Then I should have "400.00" as wallet balance
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And "Continue" button in Send Money page should be "disabled"
    And I enter "User B" mobile number from test data in the Recipient input 
    And I enter "200" in the Amount input
    And "Continue" button in Send Money page should be "enabled"
    And I click "Continue" button in Send Money page
    And I wait for Confirm Transaction page to load
    Then Displayed amout to be transfered should be "200.00"
    And Source section in Send Money page should display "My Wallet" text
    And Source section in Send Money page should display "User A" mobile number from test data
    And Destination section in Send Money page should display the following details for "User B" from test data
      | acount name   |
      | contact name  | 
      | mobile number |
    And Transaction fee section in Send Money page should be "0.00"
    And I click "Send money" button in Send Money page
    Then I should be in One-Time Pin page
    And I wait for the text message for my OTP pin
    And I enter OTP pin and click verify button
    Then popup message should contain "You've successfully sent" text
    And popup message should contain amount "200.00"

  Scenario: Transfer of wallet funds with insufficient balance to another user
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    Then I should have "400.00" as wallet balance
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And I enter "User B" mobile number in the Recipient input
    And I enter "500" in the Amount input
    Then Amount input border should be "red"
    And Amount input should have error message "You only have P400.00 in your wallet"
    And "Continue" button is "disabled" in Send Money page

  Scenario: Transfer of wallet funds using saved information in My Favorites section
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And My Favorites section should have details of "User B" displayed as a card
    And I wait for Send Money page to load
    Then Details of "User B" from test data should be filled up on the following sections
      | recipient |
      | amount    |

  Scenario: Transfer of wallet funds with wrong mobile number formatting
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And I enter the mobile number "9999999999999999999" in Recipient input
    And I enter "200" in the Amount input
    And I click "Continue" button in Send Money page
    Then Warning message titled "Send Money Error" with description "You might have entered the wrong mobile, username, or account number." should display

  Scenario: Transfer of wallet funds with an added GIF
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And I enter "User B" mobile number from test data in the Recipient input 
    And I enter "200" in the Amount input
    And I select "Add a GIF" in Personalize your message
    And I click "Select GIF" button in Send Money page
    Then Search GIF input should display
    And Search GIF input placeholder should display "Search GIPHY"
    And I click on the first GIF displayed
    Then "Select GIF" button should "not be" displayed
    And "Preview" button should "be" displayed
    And "Change GIF" button should "be" displayed
    And Preview of selected GIF should display
    And I click "Continue" button in Send Money page
    Then GIF preview should be displayed in Confirm Transaction page
    And Text "Powered by" with GIPHY icon should be displayed in Confirm Transaction page

  Scenario: Transfer of wallet funds with an added Theme
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And I enter "User B" mobile number from test data in the Recipient input 
    And I enter "200" in the Amount input
    And I select "Add a Theme" in Personalize your message
    Then Theme selection icons should display
    And "Preview" button should "be" displayed
    And I click "Continue" button in Send Money page
    Then Theme icon should display in Confirm Transaction page

  Scenario: Transfer of wallet funds with a disconnected internet connection at Send Money page
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And I turn off Wifi and Mobile data capabilities
    And I enter "User B" mobile number from test data in the Recipient input 
    And I enter "200" in the Amount input
    And I click "Continue" button in Send Money page
    Then Warning message titled "Send Money Error" with description "We ran into a connection issue. Please try again in a bit." should display

  Scenario: Transfer of wallet funds to a non-registered mobile numer
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "Send" button in wallet balance component in Wallet Tab
    Then I should be in the Send Money page
    And I enter the mobile number "09123456789" in Recipient input
    And I enter "200" in the Amount input
    And I click "Continue" button in Send Money page
    Then Warning message titled "Send Money Error" with description "The person you're sending to doesn't seem to have a Maya account yet. Invite your friend today!" should display.
    And "Share your Invite Code" button in Warning message should "be" displayed
    And "Got it!" button in Warning message should be displayed

  Scenario: Verify nagivation to Send Money page from Services page
    Given I nagivate to Maya app login page
    When I login to Maya as "User A"
    And I wait for Wallet Tab to load
    And I click "More" button in Wallet tab services component
    Then I should be in the Services Page
    And I click "Send money" button in "Essentials" component in Services page
    Then I should be in the Send Money page
    And I click back button of navigation component
    Then I should be in the Services Page
    And I click "back" button of Android navigation
    Then I should be in the Wallet tab
    And I click "Services" button in the floating shortcut component
    Then I should be in the Services Page
    And I click "Send money" button in "Essentials" component in Services page
    Then I should be in the Send Money page
    And I click back button of navigation component
    Then I should be in the Services Page

	Scenario: Verify error messages in Send Money page
		Given I nagivate to Maya app login page
		When I login to Maya as "User A"
		And I wait for Wallet Tab to load
		Then I should have "400.00" as wallet balance
		And I click "Send" button in wallet balance component in Wallet Tab
		Then I should be in the Send Money page
		And I enter the mobile number "09123456789" in Recipient input
		And I clear text on Recipient input
		Then Error message "Recipient is required" should display for input Recipient
		And I enter "0" in the Amount input
		Then Error message "Amount is required. you have P400.00 in your wallet"
		And Amount input border should be "red"
		And "Continue" button in Send Money page should be "disabled"
