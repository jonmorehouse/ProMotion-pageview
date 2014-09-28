class DynamicPageView < PM::DynamicPageView

  orientation :vertical
  cache true
  cache_size 2
  default_index 5
  page_delegate PageDelegate
  page Page

end

class DefaultDynamicPageView < PM::DynamicPageView; end
