# frozen_string_literal: true

class Activity
  class Cell
    class List < ::Application::Cell
      property :id, :key, :trackable, :owner, :created_at

      ICONS = {
        create: 'fa fa-plus',
        update: 'fa fa-pencil',
        archive: 'fa fa-archive',
        confirm: 'fa fa-check',
        decline: 'fa fa-ban',
        accept: 'fa fa-star',
        reject: 'fa fa-star-o',
        partly_accept: 'fa fa-star-half-o',
        # TODO: Change keys below
        ban: 'fa fa-lock',
        unban: 'fa fa-unlock',
        moder: 'fa fa-user-secret',
        unmoder: 'fa fa-user'
      }.freeze

      NEW_CLASS = 'new'

      def activity_icon
        content_tag(:span, nil, class: "fa-5x circle-icon #{ICONS[action]} #{new_class}")
      end

      def activity_icon_block
        return activity_icon unless new?

        link_to(root_path, remote: true) do
          activity_icon
        end
      end

      def new_class
        new? ? NEW_CLASS : ''
      end

      def action
        @action = key.split('.').last.to_sym
      end

      def owner_link
        link_to_if policy?(:show, owner), owner.full_name, owner
      end

      def text
        t(
          action,
          scope: "views.messages.activity.#{trackable.class.name.downcase}",
          link: owner_link
        )
      end

      def new?
        raise NotImplementedError
      end
    end
  end
end
