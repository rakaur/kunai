module Kunai
  class Configuration < Hash
    alias_method :_get, :[] # preserve the original #[] method
    protected :_get # make it protected

    def initialize(hash = nil)
      hash.each { |k, v| self[k] = v } if hash.present?
    end

    def []=(key, value)
      value = Configuration.new(value) if value.is_a?(Hash)
      value.map! { |v| Configuration.new(v) if v.is_a?(Hash) } if value.is_a?(Array)
      super(key.to_sym, value)
    end

    def [](key)
      super(key.to_sym)
    end

    def method_missing(name, *args)
      name_string = +name.to_s

      if name_string.chomp!("=")
        self[name_string] = args.first
      else
        bangs = name_string.chomp!("!")

        if bangs
          self[name_string].presence || raise(KeyError.new(":#{name_string} is blank"))
        else
          self[name_string]
        end
      end
    end

    def inspect
      "#<#{self.class.name} #{super}>"
    end
  end
end
