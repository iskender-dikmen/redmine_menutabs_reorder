# plugins/redmine_menutabs_reorder/init.rb

Redmine::Plugin.register :redmine_menutabs_reorder do
  name 'Redmine Project Menu Tabs Reorder'
  author 'İskender DİKMEN'
  description 'Rearranges project menu tabs.'
  version '1.0.0'
  url 'https://github.com/iskender-dikmen/redmine_menutabs_reorder.git'
  author_url 'https://github.com/iskender-dikmen'
  requires_redmine version_or_higher: '7.0.0'

  settings default: {
    'tab_order' => 'overview,activity,roadmap,issues,time_entries,gantt,calendar,news,documents,wiki,boards,files,repository,settings'
  }, partial: 'settings/menutabs_reorder_settings'
end

# Load the separate hook file cleanly
require_relative 'lib/redmine_menutabs_reorder/hooks'
