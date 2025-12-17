# frozen_string_literal: true

module Repo
  class PermissiveValidator
    def method_missing(*)
      true
    end
  end
end
