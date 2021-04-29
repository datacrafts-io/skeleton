module DatacraftsIoSkeleton
  module Tools
    class Gemfiler
      GEMS_DEFAULT_VALUE = {
        common: [],
        development: [],
        development_test: [],
        test: []
      }.freeze

      @gems = GEMS_DEFAULT_VALUE
      @uncommented_default_gems = []

      class << self
        def clean!
          @gems = GEMS_DEFAULT_VALUE
          @uncommented_default_gems = []
        end

        def add(name, group: :common, required: true)
          raise "Gem group #{group} is not supported" if @gems[group].nil?

          @gems[group].push(name: name, required: required)
        end

        def uncomment_default_gems(*names)
          @uncommented_default_gems.concat(names)
        end

        attr_reader :uncommented_default_gems

        def render(group)
          gemfile = @gems[group].map do |gem|
            "gem '#{gem[:name]}', require: #{gem[:required]}"
          end

          gemfile.join("\n")
        end
      end
    end
  end
end
