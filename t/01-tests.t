#!perl -T

use Test::More tests => 2;

{
	package TestApp;

	use Catalyst 'RelativePaths';

	sub foo : Global {
		my ($self, $c) = @_;
		$c->res->redirect($c->uri_for('/foo'));
	}

	sub bar : Global {
		my ($self, $c) = @_;
		$c->res->output($c->req->uri_with({ the_word_that_must_be_heard => 'mtfnpy' }));
	}

	__PACKAGE__->setup();
}

use Catalyst::Test 'TestApp';

is(request('/foo')->header('location'), 'foo', 'redirect location');

is(get('/bar'), 'bar?the_word_that_must_be_heard=mtfnpy', '$c->req->uri_with test');
