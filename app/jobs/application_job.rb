# Base asynchronous job class
#
# see https://guides.rubyonrails.org/active_job_basics.html
class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are
  # no longer available
  # discard_on ActiveJob::DeserializationError
end
