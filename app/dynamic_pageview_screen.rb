class DynamicPageView < PM::DynamicPageView

  cache true
  cache_size 5
  page_delegate PageDelegate
  page Page

end

class DefaultDynamicPageView < PM::DynamicPageView


end
