module Templar
  class TemplateConfig

    attr_accessor :template_name, :template_dir, :author, :first_name,
      :last_name, :webpage, :biography, :affiliation, :department, :city,
      :email, :title

    # TODO: Should we use a default object here?
    def initialize(config)
      # TODO: could you meta-program a method that does this for each attr?
      if config.respond_to?(:template_name)
        # TODO: verify if these are actually the same thing
        if config.template_name.nil? or config.template_name == ""
          @template_name = "Purdue Pete"
        else
          @template_name = config.template_name
        end
      end

      if config.respond_to?(:first_name)
        if config.first_name.nil? or config.first_name = ""
          @first_name = "Purdue"
        else
          @first_name = config.first_name
        end
      end

      if config.respond_to?(:last_name)
        if config.last_name.nil? or config.last_name = ""
          @last_name = "Pete"
        else
          @last_name = config.last_name
        end
      end

      if config.respond_to?(:email)
        @email = if config.email.nil? || config.email == ''
                   'president@purdue.edu'
                 else
                   config.email
                 end
      end

      if config.respond_to?(:location)
        @location = if config.institution.nil? || config.institution == ''
                      'West Lafayette, IN'
                    else
                      config.institution
                    end
      end

      if config.respond_to?(:institution)
        @institution = if config.institution.nil? || config.institution == ''
                         'Purdue University'
                       else
                         config.institution
                       end
      end
    end

    # TODO: meta-program a 'has_xyz?' method for each of the attributes
  end
end
