require 'set'
require_relative 'theusual/version.rb'


module TheUsual
  MODULES = [
    'array',
    'enumerable',
    'hash',
    'ipaddr',
    'mongoid',
    'net/ssh',
    'nil',
    'numeric',
    'sequel',
    'string',
    'time',
  ]


  def self.load *modules
    # some modules need to be explicitly required
    needs_load = [
      'ipaddr',
      'mongoid',
      'net/ssh',
      'sequel',
    ]

    # some of our filenames need to be remapped
    paths = {
      'net/ssh' => 'ssh',
    }

    raise ArgumentError, 'did you mean load(:all) ?' if modules.empty?

    modules.map! &:to_s
    to_load = if [:all, 'all', '*'].include? modules.first
      MODULES
    else
      modules
    end

    to_load.flatten.map(&:to_s).map do |_module|
      unless MODULES.include? _module
        raise ArgumentError.new(
          "can not load utils for module: #{_module}"
        )
      end

      begin
        # load standard lib
        require _module if needs_load.include? _module

        # monkey patch
        name = paths[_module] || _module
        require_relative "theusual/#{name}.rb"

        _module
      rescue LoadError
        # underlying gem not installed
        # for :all, just skip monkey patch
        if modules.include? _module
          raise ArgumentError.new(
            "missing library gem: gem install #{_module}"
          )
        end
      end
    end.compact
  end

end
