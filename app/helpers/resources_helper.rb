module ResourcesHelper
  def resource_image(resource)
    if resource.photo.attached?
      resource.photo.url
    else
      "default.jpg"
    end
  end
end
