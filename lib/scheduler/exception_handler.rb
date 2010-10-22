module Scheduler
  class ExceptionHandler
    def self.handle_exception(exception, job, message)
      if Rails.env.production?
        env = {}
        env['exception_notifier.options'] = Systemak::Application::EXCEPTION_NOTIFIER_OPTIONS
        env['exception_notifier.options'][:sections] = ["backtrace"]
        ExceptionNotifier::Notifier.exception_notification(env, exception).deliver
      end
    end
  end
end