# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Class_04_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
require RPerl::Test;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo qw(quux quince qorge);
require RPerl::Test::Bar;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ SUBROUTINES & OO METHODS ]]]
our integer::method $empty_method = sub {
    return RPerl::Test::Foo::quince();
};

1;                  # end of class
