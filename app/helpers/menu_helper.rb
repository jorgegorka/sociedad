module MenuHelper
  def user_menu_links
    [
      {
        name: I18n.t("admin.users.logOut"),
        link: session_path(Current.user),
        method: :delete,
        data: {},
        selected: false
      }
    ]
  end

  def selected_option(current_link)
    if current_page?(current_link)
      "inline-flex items-center border-b-2 border-indigo-500 px-1 pt-1 text-sm font-medium text-gray-900"
    else
      "inline-flex items-center px-1 pt-1 text-sm font-medium text-gray-900"
    end
  end
end
