module FindOrRedirect
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def find_or_redirect(opts = {})
      instance = (opts[:name] || controller_name).singularize
      redirect_target = opts[:redirect_to] || ":action => :index"
      klass = (opts[:name] || controller_name).classify
      finder = opts[:finder] || "#{klass}.find_by_id(params[:id].to_i)"
      filter_name = opts[:filter_name] || "find_#{ instance }_or_redirect"
      condition = opts[:if] || true
      
      class_eval <<-RUBYSRC
        before_filter :#{ filter_name }, #{ opts.inspect }
        private
        def #{ filter_name }
          @#{ instance } = #{ finder }
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

