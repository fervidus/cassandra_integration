# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include cassandra_integration::classification
class cassandra_integration::classification {
  $node_classes = getvar('trusted.external.node.puppet_classes')

  unless $node_classes == undef {
    assert_type(Array[String], $node_classes) |$expected, $actual| {
      fail("trusted.external.node.puppet_classes should be \'${expected}\' (Hash[ClassName, Parameters]), not \'${actual}\'")
    }

    # unless lookup('cassandra_integration_data_backend_present', 'default_value' => false) {
    #   fail("The cassandra_integration::getvar Hiera backend isn't setup to read class parameters from Cassandra")
    # }

    $node_classes.each |String $class| {
      unless defined($class) {
        fail("Cassandra specified an undefined class ${class}")
      }

      include $class
    }
  }
}
