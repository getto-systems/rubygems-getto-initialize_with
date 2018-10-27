module Getto
  module InitializeWith
    def self.included(m)
      m.singleton_class.class_eval do
        define_method :initialize_with do |*names,**specs|
          define_method :initialize do |**hash|
            names.each do |name|
              raise ArgumentError, "argument missing: #{name}" unless hash.has_key?(name)
              instance_variable_set :"@#{name}", hash.delete(name)
            end

            specs.each do |name,spec|
              raise ArgumentError, "argument missing: #{name}" unless hash.has_key?(name)

              entry = hash.delete(name)

              case
              when spec.is_a?(Class)
                unless entry.is_a?(spec)
                  raise ArgumentError, "argument type error: #{name} is not a #{spec}"
                end
              when spec.respond_to?(:each)
                spec.each do |method|
                  unless entry.respond_to?(method)
                    raise ArgumentError, "argument type error: #{name} is not respond_to #{method}"
                  end
                end
              else
                # :nocov:
                raise ArgumentError, "invalid spec: #{spec}"
                # :nocov:
              end

              instance_variable_set :"@#{name}", entry
            end

            raise ArgumentError, "unknown argument: #{hash.keys.join(",")}" unless hash.empty?

            self
          end

          attr_reader(*(names + specs.keys))
        end
      end
    end
  end
end
