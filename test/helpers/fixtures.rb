require "yaml"
require "erb"

module Qrier
  module Helpers
    module Fixtures
      FIXTURES_PATH = File.expand_path "../../fixtures", __FILE__

      def fixtures model
        content = File.read(File.join(FIXTURES_PATH, "#{model}.yml" ))
        erb = ERB.new(content).result binding
        list = YAML.load erb

        list.map do |item|
          data = item.inject({}) do |sum, key_value|
            sum[key_value[0].to_sym] = key_value[1]
            sum
          end

          Qrier.const_get(model.capitalize).new data
        end
      end
    end
  end
end
