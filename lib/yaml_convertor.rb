require 'yaml_convertor/version'
require 'psych'

module YamlConvertor
  def self.flattener(nested_hash)
    raise "Argument must be a Hash" unless nested_hash.is_a?(Hash)
    Convertor.new.flatten(nested_hash)
  end
  def self.builder(flat_hash)
    raise "Argument must be a Hash" unless flat_hash.is_a?(Hash)
    Convertor.new.build(flat_hash)
  end
  
  class Convertor
    def flatten(nested_hash, keyname = '')
      hash = {}
      nested_hash.each_pair do |key, value|
        if value.is_a?(Hash)
          name = keyname.empty? ? "#{key}" : "#{keyname}.#{key}"
          hash.merge!(flatten(value, name))
        else
          hash["#{keyname}.#{key}"] = value
        end
      end
      hash
    end
    def build(flat_hash)
      # create a hash where every key's value is an empty hash
      # hash[key] <- creates a key and its value will be {}
      hash = Hash.new{ |h, k| h[k] = Hash.new(&h.default_proc) }  
      flat_hash.each_pair do |key, value|
        tmp = hash
        arr_keys = key.split('.')
        arr_keys.each do |item|
          if item.eql?(arr_keys.last)
            tmp[item] = value
          else
            tmp = tmp[item] #creates key
          end
        end
      end
      hash
    end
  end
end