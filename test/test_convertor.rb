require 'test/unit'
require 'yaml_convertor'

class TestConvertor < Test::Unit::TestCase

  def test_must_return_flattened_hash
    nested_hash = {"k1"=>{"k2"=>"v", "k3"=>{"k4"=>"v", "k5"=>["v", "v"], "k6"=>{"k7"=>"v"}}, "k8"=>{"k9"=>{"k10"=>{"k11"=>"v", "k12"=>"v"}}}}}
    flat_hash = {"k1.k2"=>"v", "k1.k3.k4"=>"v", "k1.k3.k5"=>["v", "v"], "k1.k3.k6.k7"=>"v", "k1.k8.k9.k10.k11"=>"v", "k1.k8.k9.k10.k12"=>"v"}
    assert_equal flat_hash, YamlConvertor.flattener(nested_hash)
  end

  def test_must_return_nested_hash
    flat_hash = {"k1.k2"=>"v", "k1.k3.k4"=>"v", "k1.k3.k5"=>["v", "v"], "k1.k3.k6.k7"=>"v", "k1.k8.k9.k10.k11"=>"v", "k1.k8.k9.k10.k12"=>"v"}
    nested_hash = {"k1"=>{"k2"=>"v", "k3"=>{"k4"=>"v", "k5"=>["v", "v"], "k6"=>{"k7"=>"v"}}, "k8"=>{"k9"=>{"k10"=>{"k11"=>"v", "k12"=>"v"}}}}}
    assert_equal nested_hash, YamlConvertor.builder(flat_hash)
  end
end