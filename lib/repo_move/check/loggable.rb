# frozen_string_literal: true

module RepoMove
  module Check
    module Loggable
      def log_issue(rec, level: :warn, message: nil, action: nil)
        msg = if message
          message
        elsif respond_to?(:get_message, true)
          get_message(rec)
        else
          default_message(rec)
        end

        logger.send(level, msg)
        return unless action

        logger.info(action)
      end

      def default_message(rec)
        "#{self.class} for #{rec["uri"]}"
      end
    end
  end
end
