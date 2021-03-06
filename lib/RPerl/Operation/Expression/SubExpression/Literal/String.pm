# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Literal::String;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_300;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression::Literal);
use RPerl::Operation::Expression::SubExpression::Literal;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Literal::String->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Literal_236' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $self )
                . ' found where Literal_236 expected, dying' )
            . "\n";
    }
 
    # Literal -> LITERAL_STRING
    my string $value           = $self->{children}->[0];
    $rperl_source_group->{PMC} .= $value;

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::L::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group;

#    RPerl::diag( 'in Literal::String->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Literal_236' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $self ) . ' found where Literal_236 expected, dying' ) . "\n";
    }
    
    $cpp_source_group->{CPP} = $self->{children}->[0];
 
    # replace single-quoted Perl string with double-quoted C++ string, both non-interpolated
    if ((substr $cpp_source_group->{CPP}, 0, 1) eq q{'}) {
        if ((substr $cpp_source_group->{CPP}, -1, 1) eq q{'}) {
            substr $cpp_source_group->{CPP}, 0, 1, q{"};
            substr $cpp_source_group->{CPP}, -1, 1, q{"};
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP50, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal started with single-quote but not terminated with single-quote, dying' ) . "\n";
        }
    }
    elsif ((substr $cpp_source_group->{CPP}, 0, 2) eq 'q{') {
        if ((substr $cpp_source_group->{CPP}, -1, 1) eq '}') {
            substr $cpp_source_group->{CPP}, 0, 2, q{"};
            substr $cpp_source_group->{CPP}, -1, 1, q{"};
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP51, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal started with q-left-brace single-quote but not terminated with right-brace, dying' ) . "\n";
        }
    }
# NEED ADD ERROR CHECKING: double-quoted strings are okay for non-sigils containing newline or tab, non-quoted strings are not okay?
#    else {
#        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP52, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal not started with single-quote, dying' ) . "\n";
#    }

#    RPerl::diag( 'in Literal::String->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_inside_print_operator} = ' . $modes->{_inside_print_operator} . "\n" );
#    RPerl::diag( 'in Literal::String->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_inside_list_elements} = ' . $modes->{_inside_list_elements} . "\n" );
#    RPerl::diag( 'in Literal::String->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_inside_cat_operator} = ' . $modes->{_inside_cat_operator} . "\n" );

    if (     (exists $modes->{_inside_print_operator}) and (defined $modes->{_inside_print_operator}) and $modes->{_inside_print_operator} and 
             (exists $modes->{_inside_list_elements})  and (defined $modes->{_inside_list_elements})  and $modes->{_inside_list_elements}) {  # and
#        not ((exists $modes->{_inside_cat_operator})   and (defined $modes->{_inside_cat_operator})   and $modes->{_inside_cat_operator})) {
#    if (1) {
        # don't cast string literals when inside print operator and also inside list elements and also NOT inside string concatenation operator;
        # cout << will automatically detect type
        $cpp_source_group->{CPP} = $cpp_source_group->{CPP};
    }
    else {
        # cast all string literals to the RPerl-defined C++ string type
        $cpp_source_group->{CPP} = '(const string) ' . $cpp_source_group->{CPP};
    }

    return $cpp_source_group;
};

1;  # end of class
