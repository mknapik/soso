module LanguageGradesHelper
  def onoff_tag(name, value = '1', checked = false, options = {})
    html_options = {type: 'checkbox', name: name, id: sanitize_to_id(name), value: value, class: 'onoffswitch-checkbox'}.update(options.stringify_keys)
    html_options['checked'] = 'checked' if checked
    content_tag :div, class: 'onoffswitch' do
      tag(:input, html_options) +
          content_tag(:label, '', class: 'onoffswitch-label', for: name) do
            content_tag(:div, '', class: 'onoffswitch-inner') +
                content_tag(:div, '', class: 'onoffswitch-switch')
          end
    end
  end
end
