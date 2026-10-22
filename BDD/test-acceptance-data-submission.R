# Example of BDD
#https://jakubsobolewski.com/blog/bdd-shiny-feature/

#' tests/testthat/test-acceptance-data_submission.R
describe("data submission", {
  it("should submit entry to storage", {
    given_no_content() |>
      when_i_submit_entry_with_all_required_fields() |>
      then_there_are_entries(n = 1)
  })
})

Same as above, but in BDD/Gerkin:
     
Feature: Data submission
  Scenario: Submit entry to storage
    Given no content
    When I submit entry with all required fields
    Then there are 1 entries
