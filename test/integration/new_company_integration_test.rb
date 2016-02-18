require_relative "integration_test_helper"

class NewCompanyIntegrationTest < ActionDispatch::IntegrationTest

  def setup

  end

  test "visit new company page" do
    visit new_company_path

    assert page.has_content?("Add a New Company + Offices")
  end

  test "failed submit" do
    visit new_company_path

    fill_in_company_info(company_opts)
    fill_in_office_info(office_opts(city: nil))
    
    click_button 'Save'

    # assert_equal new_company_path, page.current_path
    assert page.has_content? "can't be blank"
  end

  test "successful submit" do
    visit new_company_path

    fill_in_company_info(company_opts)
    fill_in_office_info(office_opts)
    
    click_button 'Save'
  
    assert_equal companies_path, page.current_path
    assert page.has_content? 'Company successfully created.'
    assert page.has_content? company_opts[:name]
  end

  test "failed submit with multiple offices" do
    visit new_company_path

    fill_in_company_info(company_opts)
    fill_in_office_info(office_opts)

    click_button "Add Another Office"

    # need to add poltergeist first
  end

  private

  def fill_in_company_info(opts = {})
    within('div.company-details') do
      fill_in 'Name', with: opts[:name]
      fill_in 'Employee count', with: opts[:employee_count]
    end
  end

  def fill_in_office_info(opts = {})
    within('div.office-row-fieldset') do
      fill_in 'Name', with: opts[:name]
      fill_in 'City', with: opts[:city]
      fill_in 'State', with: opts[:state]
      fill_in 'Employee count', with: opts[:employee_count]
    end
  end

  def company_opts(opts = {})
    { name: 'LolCo', employee_count: 1 }.merge(opts)
  end

  def office_opts(opts = {})
    { name: 'Office1', city: 'Muskogee', state: 'OK', employee_count: 1 }.merge(opts)
  end




end