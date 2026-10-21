@login
Feature: Login Functionality

  As a user of the application
  I want to be able to log in with valid credentials
  So that I can access the secure area of the application

  Background:
    Given I am on the login page

  # ─── Positive Scenario ─────────────────────────────────────

  
  
  @visualCompare
  Scenario: Visual testing of login page
    When I enter username "tomnirajgupta"
    Then I do visual testing of login page
