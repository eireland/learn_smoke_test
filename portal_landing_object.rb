module PortalLandingObject
  SRF_HEADER = {xpath: '//h1[contains(text(),"Interactive STEM activities")]'}

  SIGNUP_MODAL = {id: 'signup-default-modal'}
  SIGNUP_SUBMIT_BUTTON = {css: '.signup-default-modal-content > .signup-form > .submit_button-container > .submit-btn'}
  SIGNUP_MODAL_GOOGLE_OPTION = {id: 'google'}
  SIGNUP_MODAL_SCHOOLOGY_OPTION = {id: 'schoology'}

  LIFE_SCIENCE_FILTER = {id: 'life-sciences'}
  ENGINEERING_TECHNOLOGY_FILTER = {id: 'engineering-technology'}
  EARTH_SPACE_SCIENCES_FILTER = {id: 'earth-space-sciences'}
  PHYSICAL_SCIENCES_FILTER = {id: 'physical-sciences'}
  SEARCH_FIELD = {xpath: '//div[contains(@class,"portal-pages-search-input-container")]/input'}
  ADVANCE_SEARCH = {id: 'advance-search-link'}
  SEARCH_BUTTON = {css: '#search > form > input.button'}
  ELEMENTARY_SCHOOL_FILTER = {id: 'elementary-school'}
  MIDDLE_SCHOOL_FILTER = {id: 'middle-school'}

  def verify_landing_page
    wait_for {displayed? (SRF_HEADER)}
    return true
  end
end

end



