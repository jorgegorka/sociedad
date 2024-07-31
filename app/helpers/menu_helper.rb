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
end
