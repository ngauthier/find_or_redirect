module FindOrRedirect
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def find_or_redirect(opts = {})
      klass = controller_name.classify
      instance = controller_name.singularize
      redirect_target = opts.delete(:redirect_to) || ":action => :index"
      finder = opts.delete(:finder) || klass
      
      class_eval <<-RUBYSRC
        before_filter :find_#{ instance }_or_redirect, #{ opts.inspect }
        private
        def find_#{ instance }_or_redirect
          @#{ instance } = #{ finder }.find_by_id params[:id]
          unless @#{ instance }
            redirect_to #{ redirect_target }
            flash[:error] = "Invalid #{ klass } ID"
            return false
          end
        end
      RUBYSRC
    end
  end
end

ActionController::Base.send :include, FindOrRedirect

