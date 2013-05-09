module Refinery
  module Jobs
    class JobApplication < ActiveRecord::Base
      HUMANIZED_COLUMNS = {:resume_file_name => "Resume"}

      belongs_to :job, :class_name => "Job", :foreign_key => "job_id"

      resource_accessor :resume

      validates_presence_of :name, :phone, :email, :cover_letter
      validates_format_of   :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
      validates             :resume, :presence => true
      validates_with FileSizeValidator

      def self.human_attribute_name(attribute)
        HUMANIZED_COLUMNS[attribute.to_sym] || super
      end
    end
  end
end