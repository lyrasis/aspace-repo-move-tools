# frozen_string_literal: true

# This gets passed in as "enum_source" when initializing JSONModel from
# ArchivesSpace common.
#
# This is not janky at all, I promise.
class PermissiveValidator
  def method_missing(*)
    true
  end
end
