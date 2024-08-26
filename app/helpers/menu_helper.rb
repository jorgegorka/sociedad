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
      "inline-flex items-center border-b-2 border-indigo-500 py-2 text-sm font-medium text-gray-900"
    else
      "inline-flex items-center py-2 text-sm font-medium text-gray-700 hover:border-b-2 hover:border-indigo-500 hover:text-gray-900"
    end
  end
end
