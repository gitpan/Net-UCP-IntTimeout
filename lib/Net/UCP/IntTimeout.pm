package Net::UCP::IntTimeout;

use 5.008007;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw();

our $VERSION = '0.01';

use constant MIN_TIMEOUT     => 0;           # No timeout at all!
use constant DEFAULT_TIMEOUT => 15;
use constant MAX_TIMEOUT     => 60;

sub new {bless({}, shift())->_init(@_);}
sub timeout {$_[0]->{TIMEOUT};}

sub _init {
    my $self = shift();
    my %args = (
		TIMEOUT => undef,
		WARN    => 0,
		@_);
    
    $self->{WARN}    = defined($args{WARN})?$args{WARN}?1:0:0;
    $self->{TIMEOUT} = DEFAULT_TIMEOUT;

    if(defined($args{TIMEOUT})) {
        if($args{TIMEOUT}=~/\D/) {
            $self->{WARN}&&warn("Non-numerical data found in entity 'TIMEOUT' when creating an object of class ".
				__PACKAGE__.
				'. '.
				'Input data: >'.
                                $args{TIMEOUT}.
                                '< Given TIMEOUT value ignored and default value '.DEFAULT_TIMEOUT.' used instead');
        }
	
# The commented code will never be executed until we let the MIN_TIMEOUT be greater than zero (since the '-' is non-numeri)
#      elsif($args{TIMEOUT}<MIN_TIMEOUT) {
#         $self->{WARN}&&warn("Entity 'TIMEOUT' contains a value smaller than the smallest value allowed (".
#                             MIN_TIMEOUT.
#                             ") when creating an object of class ".
#                             __PACKAGE__.
#                             '. Given TIMEOUT value ignored and default value '.DEFAULT_TIMEOUT.' used instead');
        elsif($args{TIMEOUT}>MAX_TIMEOUT) {
            $self->{WARN}&&warn("Entity 'TIMEOUT' contains a value greater than the largest value allowed (".
				MAX_TIMEOUT.
				") when creating an object of class ".
				__PACKAGE__.
                                '. Given TIMEOUT value ignored and default value '.DEFAULT_TIMEOUT.' used instead');
        }
        else {
            $self->{TIMEOUT}=$args{TIMEOUT};
        }
    }
    
    $self;
}

1;
__END__

=head1 NAME

Net::UCP::IntTimeout - Perl 

=head1 SYNOPSIS

  use Net::UCP::IntTimeout;
 
=head1 DESCRIPTION

This module is used by Net::UCP to manage timeout during message transmission

=head2 EXPORT

None 

=head1 SEE ALSO

Net::UCP

=head1 AUTHOR

Marco Romano, E<lt>nemux@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Marco Romano

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.7 or,
at your option, any later version of Perl 5 you may have available.


=cut
