module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/en'

    when /Anzeigeseite des Feedbackbogens/
      sheet_path(Sheet.last.id, :locale => 'en')

    when /the sheets show page/
      sheet_path(Sheet.last, :locale => 'en')
    when /the last sheets show page/
      sheet_path(Sheet.last, :locale => 'en')
    when /login/
      new_session_path(:locale => 'en')

    when /sheets edit page/
      edit_sheet_path(Sheet.last, :locale => 'en')

    when /user admin page/
      admin_users_path(:locale => 'en')

    when /search page/
      search_sheets_path(:locale => 'en')
    when /semesters index page/
      admin_semesters_path(:locale => 'en')
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

