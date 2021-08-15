module DatacraftsIoSkeleton
  module Tools
    class Gemfiler
      GEMS_DEFAULT_GROUPS = %i[common development development_test test].freeze

      class << self
        def clean!
          build_empty_gemset
        end

        def add(name, group: :common, required: true)
          raise "Gem group #{group} is not supported" unless GEMS_DEFAULT_GROUPS.include?(group)

          @gems[group].push(name: name, required: required)
        end

        def uncomment_default_gems(*names)
          @uncommented_default_gems.concat(names)
        end

        attr_reader :uncommented_default_gems

        def render(group)
          gemfile = @gems[group].map do |gem|
            base = "gem '#{gem[:name]}'"
            required = gem[:required] == true ? nil : "require: #{gem[:required]}"
            [base, required].compact.join(", ")
          end

          gemfile.join("\n")
        end

        def build_empty_gemset
          @gems = GEMS_DEFAULT_GROUPS.collect { |group| [group, []] }.to_h
          @uncommented_default_gems = []
        end
      end

      build_empty_gemset
    end
  end
end
