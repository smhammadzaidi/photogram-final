module ApplicationHelper
  def image_tag_with_identifier(image, options = {})
    if image.respond_to?(:attached?) && image.attached?
      filename = image.filename.to_s
      options[:src] = url_for(image) + "?filename=#{filename}"
      tag.img(**options)
    else
      ""
    end
  end
end
