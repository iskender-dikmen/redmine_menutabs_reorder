module RedmineMenutabsReorder
  class Hooks < Redmine::Hook::ViewListener
    # Triggered during head layout processing (Handles project level screens)
    def view_layouts_base_html_head(context = {})
      process_menu_reordering_and_translations
      return ''
    end

    # Triggered at body termination pass (Catches top-level index contexts when no project is selected)
    def view_layouts_base_body_bottom(context = {})
      process_menu_reordering_and_translations
      return ''
    end

    private

    def process_menu_reordering_and_translations
      saved_order_string = (Setting.plugin_redmine_menutabs_reorder['tab_order'] rescue '').to_s.strip
      return if saved_order_string.blank?

      custom_order = saved_order_string.split(',').map(&:strip).map(&:to_sym)

      # Apply translation lookups and sorting across both project and application menus
      [:project_menu, :application_menu].each do |menu_name|
        root_node = Redmine::MenuManager.items(menu_name)

        if root_node.respond_to?(:children) && root_node.children.present?

          # STEP 1: Overwrite pre-compiled labels and silence the browser tooltip popups
          root_node.children.each do |node|
            custom_title = I18n.t("project_tab_titles.#{node.name}", default: nil)
            if custom_title.present?
              node.instance_variable_set(:@caption, custom_title)

              # Explicitly remove or blank out the HTML title attribute to disable the black hover tooltips
              if node.instance_variable_get(:@html_options).is_a?(Hash)
                node.html_options.delete(:title)
                node.html_options.delete('title')
              end

              # Allow the custom method override to accept context arguments (*args) passed by Redmine's helper engine
              node.instance_eval do
                @caption = custom_title
                define_singleton_method(:caption) { |*args| @caption }
              end
            end
          end

          # STEP 2: Enforce custom drag-and-drop priority sequence
          sorted_nodes = root_node.children.sort_by do |node|
            if menu_name == :application_menu && node.name == :projects
              # Force the global 'Projects' tab to stay at the absolute left of the main menu
              -2
            elsif node.name == :new_object || node.name.to_s.start_with?('new_')
              # Keeps any creation macros (+ dropdowns) securely anchored at the front indexes
              -1
            else
              # Apply custom drag-and-drop configuration order weights
              custom_order.index(node.name.to_sym) || 999
            end
          end

          # Update the current request's children matrix memory layout safely
          root_node.instance_variable_set(:@children, sorted_nodes)
        end
      end
    end
  end
end
